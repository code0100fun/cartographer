require 'spec_helper'
require_relative '../lib/cartographer/teleport'

describe Cartographer::Teleport do
  it 'constructs a teleport command' do
    teleport = Cartographer::Teleport.new name: 'code0100fun', x: 5000, y:1000, z:-3000
    expect(teleport.command_text).to eq('teleport.topos "code0100fun" "5000" "1000" "-3000"')
  end
end

