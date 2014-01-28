require 'rbconfig'

module Cartographer
  class Job
    attr_reader :grid, :name, :wait
    def initialize name, grid, wait
      @name = name
      @grid = grid
      @wait = wait
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

    def screenshot index, x, y, z
      dir = "./output"
      path = "#{dir}/map_#{index}_#{x}_#{y}_#{z}.png"
      if windows?
        require 'win32/screenshot'
        Win32::Screenshot::Take.of(:foreground).write(path)
      else
        `screencapture #{path}`
      end
    end

  end
end
