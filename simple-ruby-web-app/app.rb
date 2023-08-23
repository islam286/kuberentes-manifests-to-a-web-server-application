require 'sinatra'
require 'json'

set :server, 'webrick'  # Specify Webrick server

get '/health' do
  content_type :json
  { msg: 'healthy' }.to_json
end
get '/' do
  "Hello World"
end


# Set the port for the Sinatra application
set :port, 8080
