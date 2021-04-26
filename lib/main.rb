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
    def initialize(status, body)
        @status = status
        @body = body
    end
    def to_s
        "{status code: #{status}, body: #{body}}"
    end
end

# logo um echo server responde sempre 200 com hello world
class ServerHandler
    def self.handle(req)
        return Resp.new(200, "hello world")
    end
end

class Middleware
    def initialize(next_middleware)
        @next_middleware = next_middleware
    end
end

class Log < Middleware
    def handle(req)
        puts "Request #{req} received"
        resp = @next_middleware.handle(req)
        puts "Response: #{resp}"
        resp
    end
end

class Authentication < Middleware
    def handle(req)
        if req.headers[:user] == 'Admin' and req.headers[:pwd] == 'admin' 
            @next_middleware.handle(req)
        else
            Resp.new(403, "Req denied")
        end
    end
end

s = Log.new(Authentication.new(ServerHandler))
s.handle(Req.new(headers:{user: 'Admin', pwd: 'admin'}))
s.handle(Req.new)


# crie middleware / testes / projeto no github e a execução deles para decorar o echo server acima


# Criar um Log para Logar Req xx antes de executar e Resp depois da execução
# Negar requests (status 403) sem user=Admin pwd=admin nos headers

# Contar tempo levado por cada requests
# Metrificar quantidade de respostas por status code
# Criar cache onde a chave é o path e que respeite o header Caching=<time>
# Devolver 404 para qualquer path *php