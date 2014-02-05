require 'readline'
require 'colorize'

module Cartographer
  class Cli

    def ask parameter, options={}
      default = options[:default]
      input = Readline.readline("#{parameter}#{default.nil? ? "" : " (#{default})" } > ", true)
      input.empty? ? default : input
    end

    def execute!
      start_x = ask('start x', default: 3800).to_f
      start_z = ask('start z', default: -6000).to_f
      height = ask('height', default: 1000).to_f
      step_x = ask('step x', default: 100).to_f
      step_z = ask('step z', default: 100).to_f
      max_x = ask('max x', default: 7500).to_f
      max_z = ask('max z', default: -1600).to_f
      user = ask('user')
      pause = ask('pause', default: 0.5).to_f
      output = ask('output', default: './output')
      options = {
        x: start_x,
        y: height,
        z: start_z,
        step_x: step_x,
        step_z: step_z,
        max_x: max_x,
        max_z: max_z
      }
      puts "Running job..."
      puts options.inspect
      puts "User: #{user}"
      puts "Pause: #{pause}"
      grid = Cartographer::Grid.new options
      job = Cartographer::Job.new user, grid, pause, output
      job.run
    rescue Interrupt
      puts "Exiting..."
    end

  end
end

