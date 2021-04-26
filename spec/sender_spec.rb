# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sender do
  it 'prints mocked message to output' do
    expect do
      Sender.email
    end.to output("email enviado\n").to_stdout
  end
end
