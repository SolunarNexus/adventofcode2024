#!/usr/bin/ruby
require './part_one.rb'

def load_input(filename)
  map = Array.new
  instructions = String.new
  robot_position = nil
  input = File.read(filename, chomp: true).split(/\n\n/)

  input[0].each_line(chomp: true).with_index do |line, line_idx|
    map.append ""

    line.each_char do |char|
      if char == Warehouse::EMPTY
        map[line_idx] += ".."
      elsif char == Warehouse::WALL
        map[line_idx] += "##"
      elsif char == Warehouse::BOX
        map[line_idx] += "[]"
      elsif char == '@'
        map[line_idx] += "@."
        robot_position = [map[line_idx].index('@'), line_idx]
      end
    end
  end

  input[1].each_line(chomp: true) do |line|
    instructions += line
  end
  [map, instructions, robot_position]
end

# TODO: solve part two appropriately

map, instructions, robot = load_input("test_input2")
puts map
puts instructions
puts robot
