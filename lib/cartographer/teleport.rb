require 'rust'

module Cartographer
  class Teleport

    attr_reader :name, :x, :y, :z

    def initialize options
      @name = options[:name]
      @x = options[:x]
      @y = options[:y]
      @z = options[:z]
    end

    def command_text
      "teleport.topos \"#{name}\" \"#{x}\" \"#{y}\" \"#{z}\""
    end

    def run
      puts command_text
      command = Rust::Command.new command_text
      res = command.run
      puts res.inspect
    end

  end
end

