require 'spec_helper'
require_relative '../lib/command'

describe Cartographer::Command do

  subject(:command){ Cartographer::Command.new 'teleport.topos "code0100fun" "5000" "1000" "-3000"' }

  xit 'sends teleport command to server' do
    response = command.run
    expect(response["success"]).to eq(true)
  end

end
