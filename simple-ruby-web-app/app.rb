require 'sinatra'
require 'json'

configure do
  set :allow_origin, '*' # Change this to your frontend's domain in production
  set :allow_methods, 'GET'
end

before do
  response.headers['Access-Control-Allow-Origin'] = settings.allow_origin
  response.headers['Access-Control-Allow-Methods'] = settings.allow_methods
end

# Your route definitions here
get '/health' do
  content_type :json
  { msg: 'healthy' }.to_json
end

get '/' do
  content_type :json
  { msg: 'healthy' }.to_json
end