require_relative '../api_server.rb'
require 'spec_helper.rb'
require 'rspec'
require 'rack/test'
require 'simplecov'
require 'factory_girl'
SimpleCov.start


set :environment, :test

describe 'ApiServer' do
  include Rack::Test::Methods
  # let(:first_view_page) { FactoryGirl.build(:page_view) }

  def app
    Sinatra::Application
  end

  it "should load successfully" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "should load ok" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should load the visit ip in the json response" do
    get '/api/v1/'
    # the_ip = first_view_page.visit.visit_ip
    expect(last_response.body).to include('24.6.5.33') 
  end  
end