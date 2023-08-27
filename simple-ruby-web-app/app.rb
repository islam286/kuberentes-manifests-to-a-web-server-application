require 'webrick'
require 'json'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.header['Access-Control-Allow-Origin'] = '*'
    response.header['Access-Control-Request-Method'] = 'GET'
    
    if request.request_method == "GET"
      res = { msg: "healthy" }
      response.status = 200
      response.content_type = "text/plain"
      response.body = res.to_json
    end
  end
end

server = WEBrick::HTTPServer.new(Port: 4567)
server.mount('/health', MyServlet)
trap('INT') { server.shutdown } 
server.start
