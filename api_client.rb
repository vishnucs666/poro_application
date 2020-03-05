# frozen_string_literal: true

require 'active_record'
require 'json'
require 'net/http'
require 'yaml'

# DB

DB_CONFIG = YAML.safe_load(File.open('config/database.yml'))

ActiveRecord::Base.establish_connection(
  adapter: DB_CONFIG['development']['adapter'],
  host: DB_CONFIG['development']['host'],
  database: DB_CONFIG['development']['database'],
  username: DB_CONFIG['development']['username'],
  password: DB_CONFIG['development']['password']
)

# Models

class Visit < ActiveRecord::Base
  has_many :page_views
  validates :evid, format: { with: /\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/,
                             message: 'Please check the referrer name format' }
end

class PageView < ActiveRecord::Base
  belongs_to :visit
end

# Service Object

class ApiService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def generate_result
    message = ''
    data['the_response'][0..3].each do |value|
      the_visit = save_the_visit(value)
      the_visit.errors.empty? ? save_page_view(value, the_visit.id) : (message += the_visit.errors.full_messages.to_s)
    end
    message
  end

  def save_the_visit(value)
    Visit.find_or_create_by(
      evid: value['referrerName'],
      vendor_site_id: value['idSite'],
      vendor_visit_id: value['idVisit'],
      visit_ip: value['visitsitIp'],
      vendor_visitor_id: value['visitIp']
    )
  end

  def validate_refferername(name)
    name[/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/]
  end

  def save_page_view(value, visit_id)
    value['actionDetails'].inject(1) do |count, val|
      PageView.find_or_create_by!(
        visit_id: visit_id,
        title: val['pageTitle'],
        position: count,
        url: val['url'],
        time_spent: val['timeSpent'],
        timestamp: val['timestamp']
      )
      count + 1
    end
  end
end

class ApiClient
  def call
    url = 'http://localhost:4567/api/v1/'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    the_parsed_response = JSON.parse(response)
    the_output = ApiService.new(the_parsed_response).generate_result

    puts the_output.present? ? the_output : 'success'
  end
end

ApiClient.new.call
