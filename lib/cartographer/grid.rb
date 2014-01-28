module Cartographer
  class Grid
    attr_reader :x, :y, :z, :step_x, :step_z, :max_x, :max_z
    def initialize options
      @x = options[:x]
      @y = options[:y]
      @z = options[:z]
      @step_x = options[:step_x]
      @step_z = options[:step_z]
      @max_x = options[:max_x]
      @max_z = options[:max_z]
    end

    def loop
      cur_x = x
      index_x = 1

      while cur_x < max_x
        cur_z = z
        index_z = 1
        while cur_z < max_z
          index = index_x * 100 + index_z
          yield index, cur_x, y, cur_z
          cur_z += step_z
          index_z += 1
        end
        cur_x += step_x
        index_x += 1
      end

    end
  end
end
