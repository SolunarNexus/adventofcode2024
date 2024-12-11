#!/usr/bin/ruby

def load_input(filename)
  topographic_map = []

  File.readlines(filename, chomp: true).each_with_index do |line, line_idx|
    topographic_map.append line.chars.map { |char| Integer(char) }
  end
  topographic_map
end

def locate_trailheads(map)
  trailheads = []

  map.each_with_index do |line, line_idx|
    line.each_with_index do |position, position_idx|
      if position == 0
        trailheads.append [line_idx, position_idx]
      end
    end
  end
  trailheads
end

def pretty_print_map(topographic_map)
  topographic_map.each do |line|
    puts line.join('')
  end
end

topographic_map = load_input('test_input')
trailheads_coords = locate_trailheads(topographic_map)

pretty_print_map(topographic_map)
puts "#{trailheads_coords}"