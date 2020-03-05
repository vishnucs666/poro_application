require 'sinatra'
require "sinatra/json"
require 'sinatra/namespace'

get '/' do
	'Welcome to our page visits tracker!'	
end

namespace '/api/v1' do

	before do
	   content_type 'application/json'
	end

	get '/' do
		my_file = File.read(File.join('samples', 'api_response.json'))
		the_parsed_response = JSON.parse(my_file.strip)
		json the_parsed_response
	end

end