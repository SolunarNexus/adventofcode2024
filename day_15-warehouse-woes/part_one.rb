#!/usr/bin/ruby

module Warehouse
  BOX = 'O'
  WALL = '#'
  EMPTY = '.'
end

def load_input(filename)
  map = Array.new
  instructions = String.new
  input = File.read(filename, chomp: true).split(/\n\n/)

  input[0].each_line(chomp: true) do |line|
    map.append line
  end

  input[1].each_line(chomp: true) do |line|
    instructions += line
  end
  [map, instructions]
end

map, instructions = load_input('test_input2')

puts map
puts "#{instructions}"