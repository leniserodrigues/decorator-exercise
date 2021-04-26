# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServerHandler do
  it 'returns a 200 response' do
    resp = ServerHandler.handle(Req.new)
    expect(resp.status).to eq(200)
    expect(resp.body).to eq("hello world")
  end
end
