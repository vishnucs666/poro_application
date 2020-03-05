require 'factory_girl'
require 'simplecov'
SimpleCov.start
require File.join(File.dirname(__FILE__), "..", "api_server.rb")

%w{
  rubygems
  sinatra
  rack/test
  factory_girl
  rspec
  pp

}.each { |r| require r }

# set :environment, :test

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end