module Cartographer

  Vector = Struct.new(:x, :z) do
    def subtract vec
      OpenStruct.new x: (vec.x - self.x), z: (vec.z - self.z)
    end

    def distance vec
      Math.sqrt((vec.x - self.x)**2 + (vec.z - self.z)**2)
    end
  end

  class Scale
    attr_accessor :scale, :p1, :ep1, :p2, :ep2

    def initialize scale
      @scale = scale
    end

    def adjust?
      not adjust.nil?
    end

    def adjust
      if !correct_scale? || !correct_offset?
        OpenStruct.new scale: new_scale, offset: new_offset
      else
        OpenStruct.new
      end
    end

    def correct_offset?
      offset_error_1.x == 0 &&
        offset_error_2.x == 0 &&
        offset_error_1.z == 0 &&
        offset_error_2.z == 0
    end

    def correct_scale?
      offset_error_1.x == offset_error_2.x && offset_error_1.z == offset_error_2.z
    end

    def offset_error_1
      p1.subtract ep1
    end

    def offset_error_2
      p2.subtract ep2
    end

    def new_offset
      x1 = offset_error_1.x
      z1 = offset_error_1.z
      x2 = offset_error_2.x
      z2 = offset_error_2.z
      OpenStruct.new x1: x1, z1: z1, x2: x2, z2: z2
    end

    def scale_error
      measured / distance
    end

    def new_scale
      scale * scale_error
    end

    def distance
      p1.distance p2 unless p1.nil? || p2.nil?
    end

    def measured
      ep1.distance ep2 unless ep1.nil? || ep2.nil?
    end

  end
end
