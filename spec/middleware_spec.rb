# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Authentication do
  it 'returns 403 when invalid user and pwd' do
    server = Authentication.new(ServerHandler)
    resp = server.handle(Req.new)
    expect(resp.status).to eq(403)
    expect(resp.body).to eq("Req denied")
  end
  it 'returns 200 when valid user and pwd' do
    server = Authentication.new(ServerHandler)
    resp = server.handle(Req.new(headers: {user: 'Admin', pwd: 'admin'}))
    expect(resp.status).to eq(200)
    expect(resp.body).to eq("hello world")
  end
end


RSpec.describe Redirect do
  it 'returns 302 with location when path is /oldpath' do
    server = Redirect.new(ServerHandler)
    resp = server.handle(Req.new(path: '/oldpath'))
    expect(resp.status).to eq(302)
    expect(resp.headers[:location]).to eq("/newplace")
  end
  it 'returns 200 when path different than /oldpath' do
    server = Redirect.new(ServerHandler)
    resp = server.handle(Req.new(path: '/anything'))
    expect(resp.status).to eq(200)
    expect(resp.body).to eq("hello world")
  end
end


