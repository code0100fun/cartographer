require 'rbconfig'
require 'fileutils'

module Cartographer
  class Job
    attr_reader :grid, :name, :wait
    def initialize name, grid, wait, output
      @name = name
      @grid = grid
      @wait = wait
      @output = output
    end

    def run
      grid.loop do |index, x, y, z|
        teleport = Cartographer::Teleport.new name: name, x: x, y: y, z: z
        teleport.run
        sleep wait
        screenshot index,x,y,z
      end
    end

    def windows?
      (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    end

    def window_id
      @_window_id ||= `#{File.dirname(__FILE__)}/../../bin/GetWindowID "PlayRust"`.chomp
    end

    def screenshot index, x, y, z
      FileUtils.mkdir_p(@output) unless File.directory?(@output)
      path = "#{@output}/map_#{index}_#{x}_#{y}_#{z}.png"
      if windows?
        require 'win32/screenshot'
        Win32::Screenshot::Take.of(:foreground).write(path)
      else
        puts "screencapture -l#{window_id} #{path}"
        `screencapture -l#{window_id} #{path}`
      end
    end

  end
end
