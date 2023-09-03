require 'sinatra'
require 'json'
require 'webrick'

set :port, 4567

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/health' do
  content_type :json
  status 200
  { msg: 'healthy' }.to_json
end
