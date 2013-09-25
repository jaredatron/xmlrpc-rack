require "xmlrpc/rack/version"

class XMLRPC::Rack

  def initialize xmlrpc_server
    @xmlrpc_server = xmlrpc_server
    unless @xmlrpc_server.respond_to? :process
      raise ArgumentError, "xml rpc server must respond to `process'"
    end
  end

  def call env

    request = Rack::Request.new(env)

    if request.request_method != "POST"
      return [400,{},['request must be a post']]
    end

    if request.content_type !~ %r{^text/xml}
      return [400,{},['Content-type must be text/xml']]
    end

    length = (request.content_length || 0).to_i

    if length <= 0
      return [400,{},['post body content requied']]
    end

    data = request.body.read

    if data.nil?
      return [400,{},['post body cannot be empty']]
    end

    if data.bytesize != length
      return [400,{},['post body length does not match Content-Length']]
    end

    response = @xmlrpc_server.process(data)
    if response.nil? or response.bytesize <= 0
      return [500, {}, ['']]
    end

    headers = {
      'Content-Type' => "text/xml; charset=utf-8",
      'Content-Length' => response.bytesize.to_s
    }

    [200, headers, [response]]

  end

end
