require 'ostruct'
require 'spec_helper'
require_relative '../lib/cartographer/scale'

describe Cartographer::Scale do
  subject(:current_scale) { 2 }
  subject(:scale) { Cartographer::Scale.new current_scale }
  subject(:p1) { Cartographer::Vector.new(0, 0) }
  subject(:p2) { Cartographer::Vector.new(0, 1) }
  subject(:ep1) { Cartographer::Vector.new(0, 0) }
  subject(:ep2) { Cartographer::Vector.new(0, 2) }

  before do
    scale.p1 = p1
    scale.p2 = p2
    scale.ep1 = ep1
    scale.ep2 = ep2
  end

  describe '#distance' do
    it 'calculates distance between p1 and p2' do
      expect(scale.distance).to eq(1.0)
    end
  end

  describe '#measured' do
    it 'calculates distance between ep1 and ep2' do
      expect(scale.measured).to eq(2.0)
    end
  end

  describe '#scale_error' do
    it 'calculates scale error' do
      expect(scale.scale_error).to eq(2.0)
    end
  end

  describe '#new_scale' do
    it 'calculates the new scale' do
      expect(scale.new_scale).to eq(1.0)
    end
  end

  describe '#offset_error_1' do
    it 'calculates the offset error between p1 and ep1' do
      expect(scale.offset_error_1.x).to eq(0.0)
      expect(scale.offset_error_1.z).to eq(0.0)
    end
  end

  describe '#offset_error_2' do
    it 'calculates the offset error between p2 and ep2' do
      expect(scale.offset_error_2.x).to eq(0.0)
      expect(scale.offset_error_2.z).to eq(1.0)
    end
  end

  describe '#correct_scale?' do
    context 'errors are different' do
      it 'determines if scale is correct and offset just needs to be adjusted' do
        expect(scale.correct_scale?).to eq(false)
      end
    end

    context 'errors are the same' do
      it 'determines if scale is correct and offset just needs to be adjusted' do
        scale.ep2 = p2
        expect(scale.correct_scale?).to eq(true)
      end
    end
  end

  describe '#correct_offset?' do
    context 'offset errors are all zero' do
      it 'returns true' do
        scale.ep2 = p2
        expect(scale.correct_offset?).to eq(true)
      end
    end

    context 'offser errors are different' do
      it 'returns false' do
        expect(scale.correct_offset?).to eq(false)
      end
    end
  end

  describe '#new_offset' do

    context 'no error between measured and actual points' do
      it 'new offset is zero vector' do
        scale.ep2 = p2
        expect(scale.new_offset.x).to eq(0)
        expect(scale.new_offset.z).to eq(0)
      end
    end

    context 'error in the z direction between points' do
      it 'new offset has zero x and adjusted z' do
        scale.ep1 = Cartographer::Vector.new(0, 1)
        expect(scale.new_offset.x).to eq(0)
        expect(scale.new_offset.z).to eq(1)
      end
    end

    context 'error in the x direction between points' do
      it 'new offset has zero z and adjusted x' do
        scale.p1 = Cartographer::Vector.new(0, 0)
        scale.ep1 = Cartographer::Vector.new(1, 0)
        scale.p2 = Cartographer::Vector.new(0, 1)
        scale.ep2 = Cartographer::Vector.new(1, 1)
        expect(scale.new_offset.x).to eq(1)
        expect(scale.new_offset.z).to eq(0)
      end
    end

    context 'errors are not the same' do
      it 'averages the offset error for p1 and p2' do
        scale.p1 = Cartographer::Vector.new(0, 0)
        scale.ep1 = Cartographer::Vector.new(1, 0)
        scale.p2 = Cartographer::Vector.new(0, 1)
        scale.ep2 = Cartographer::Vector.new(0, 2)
        expect(scale.new_offset.x).to eq(0.5)
        expect(scale.new_offset.z).to eq(0.5)
      end
    end

  end

  describe '#adjust' do
    context 'scale is wrong' do
      it 'returns adjustment with scale' do
        expect(scale.adjust.scale).to eq(1)
      end
    end

    context 'scale is good, offset is wrong' do
      it 'returns adjustment with offset' do
        scale.p1 = Cartographer::Vector.new(0, 0)
        scale.ep1 = Cartographer::Vector.new(1, 1)
        scale.p2 = Cartographer::Vector.new(0, 1)
        scale.ep2 = Cartographer::Vector.new(1, 2)
        expect(scale.adjust.offset.x).to eq(1)
        expect(scale.adjust.offset.z).to eq(1)
      end
    end
  end

end

