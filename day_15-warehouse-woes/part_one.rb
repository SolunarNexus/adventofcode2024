#!/usr/bin/ruby

module Warehouse
  BOX = 'O'
  WALL = '#'
  EMPTY = '.'
end

def load_input(filename)
  map = Array.new
  instructions = String.new
  robot_position = nil
  input = File.read(filename, chomp: true).split(/\n\n/)

  input[0].each_line(chomp: true).with_index do |line, line_idx|
    map.append line

    if robot_position.nil?
      robot_x_pos = line.index('@')
      robot_position = robot_x_pos.nil? ? nil : [line_idx, robot_x_pos]
    end
  end

  input[1].each_line(chomp: true) do |line|
    instructions += line
  end
  [map, instructions, robot_position]
end

map, instructions, robot = load_input('test_input2')

puts map
puts "#{instructions}"
puts robot