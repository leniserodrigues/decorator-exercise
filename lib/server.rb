# frozen_string_literal: true

# imagine um servidor que recebe Req
class Req
    # client_ip, path e body são string
    # headers é um hash {'key' => 'value'}
    attr_accessor :client_ip, :path, :headers, :body
    def initialize(client_ip:nil, path:nil, headers:{}, body:nil)
        @client_ip = client_ip
        @path = path
        @headers = headers
        @body = body
    end
    def to_s
        "{client_ip: #{client_ip}, path: #{path}, headers: #{headers}, body: #{body}}"
    end
end


# e responde um Resp
class Resp
    # status é um int de 200 a 599
    # body é uma string
    # headers é um hash {'key' => 'value'}
    attr_accessor :status, :body, :headers
    def initialize(status:nil, body:nil, headers:{})
        @status = status
        @body = body
        @headers = headers
    end
    def to_s
        "{status code: #{status}, body: #{body}, headers: #{headers}}"
    end
end

# logo um echo server responde sempre 200 com hello world
class ServerHandler
    def self.handle(req)
        return Resp.new(status: 200, body: "hello world")
    end
end

