# frozen_string_literal: true

require_relative 'middleware'
require_relative 'server'

s = Log.new(Authentication.new(ServerHandler))
s.handle(Req.new(headers:{user: 'Admin', pwd: 'admin'}))
s = Log.new(Redirect.new(ServerHandler))
s.handle(Req.new(path:'/oldpath'))
s = Log.new(TimeCounter.new(ServerHandler))
s.handle(Req.new)


# Metrificar quantidade de respostas por status code
# Criar cache onde a chave é o path e que respeite o header Caching=<time>
# Devolver 404 para qualquer path *php
