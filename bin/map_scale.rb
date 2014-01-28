#!/usr/bin/env ruby

require_relative '../lib/cartographer'

puts "Current map scale >"
current_scale = gets.chomp.to_f
scale = Cartographer::Scale.new current_scale

puts "Pick desired point 1. It should be a small recognizable location."

puts "Desired x1 > " + "6061"
# x1 = gets.chomp.to_f
x1 = 6061

puts "Desired z1 > " + "-3561"
# z1 = gets.chomp.to_f
z1 = -3561

scale.p1 = Cartographer::Vector.new(x1, z1)

puts "Teleport to point 1"
puts "If you are off, figure out the coodinates the map thinks you are at."

puts "Error ex1 >"
ex1 = gets.chomp.to_f

puts "Error ez1 >"
ez1 = gets.chomp.to_f

scale.ep1 = Cartographer::Vector.new(ex1, ez1)

puts "Pick desired point 2. It should be a small recognizable location."

puts "Desired x2 > 5249"
# x2 = gets.chomp.to_f
x2 = 5249

puts "Desired z2 > -4717"
# z2 = gets.chomp.to_f
z2 = -4717

scale.p2 = Cartographer::Vector.new(x2, z2)

puts "Teleport to point 2"
puts "If you are off, figure out the coodinates the map thinks you are at."

puts "Error ex2 >"
ex2 = gets.chomp.to_f

puts "Error ez2 >"
ez2 = gets.chomp.to_f

scale.ep2 = Cartographer::Vector.new(ex2, ez2)

puts "Actual distance: #{scale.distance}"
puts "Measured distance: #{scale.measured}"
puts "Distance Ratio: #{scale.scale_error}"
puts "Offset Error: x1:#{scale.offset_error_1.x}, z1:#{scale.offset_error_1.z}"
puts "Offset Error: x2:#{scale.offset_error_2.x}, z2:#{scale.offset_error_2.z}"
adjust = scale.adjust
puts "Adjustment:"
puts "Scale: #{adjust.scale}" unless adjust.scale.nil?
puts "Offset: x1:#{adjust.offset.x1}, z1:#{adjust.offset.z1}, x2:#{adjust.offset.x2}, z2:#{adjust.offset.z2}" unless adjust.offset.nil?




