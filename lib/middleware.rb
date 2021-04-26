# frozen_string_literal: true

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
            Resp.new(status: 403, body: "Req denied")
        end
    end
end

class Redirect < Middleware
    def handle(req)
        if req.path == '/oldpath'
            Resp.new(status: 302, headers:{location: '/newplace'})
        else
            @next_middleware.handle(req)
        end
    end
end

class TimeCounter < Middleware
    def handle(req)
        start = Time.now
        @next_middleware.handle(req)
        stop = Time.now
        delta = stop - start
        puts ("it took %.3f s to execute request" % delta)
    end
end


