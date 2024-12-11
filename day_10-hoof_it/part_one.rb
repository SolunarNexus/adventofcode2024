#!/usr/bin/ruby

def load_input(filename)
  topographic_map = []

  File.readlines(filename, chomp: true).each_with_index do |line, line_idx|
    topographic_map.append line.chars.map { |char| Integer(char) }
  end
  topographic_map
end

topographic_map = load_input('test_input')

def pretty_print_map(topographic_map)
  topographic_map.each do |line|
    puts line.join('')
  end
end

pretty_print_map(topographic_map)
