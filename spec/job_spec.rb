require 'spec_helper'
require_relative '../lib/cartographer'

describe Cartographer::Job do
  it 'teleports a user in a grid pattern' do
    options = {
      x: 3800,
      y: 1000,
      z:-6000,
      step_x: 50,
      step_z: 50,
      max_x: 7500,
      max_z: -1600
    }
    grid = Cartographer::Grid.new options
    job = Cartographer::Job.new "code0100fun", grid, 0.5
    job.run
  end
end

