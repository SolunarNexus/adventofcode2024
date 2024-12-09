#!/usr/bin/ruby

def get_antennas_coordinates(map)
  antennas = Hash.new

  map.each_with_index do |line, line_idx|
    line.each_char.with_index do |char, char_idx|
      if char != '.'
        unless antennas.has_key? char
          antennas[char] = Array.new
        end
        antennas[char].append([line_idx, char_idx])
      end
    end
  end
  antennas
end

def is_within_bounds(coordinates)
  coordinates[0] >= 0 && coordinates[0] < @map_length && coordinates[1] >= 0 && coordinates[1] < @map_width
end

def mark_antinodes(map, antinodes)
  antinodes.each do |coordinates|
    if map[coordinates[0]][coordinates[1]] == '.'
      map[coordinates[0]][coordinates[1]] = '#'
    end
  end
end

def compute_antinodes_with_resonant_harmonics_effect(antinodes, delta, first_antinode)
  while is_within_bounds(first_antinode)
    unless antinodes.include?(first_antinode)
      antinodes.append(first_antinode)
    end
    first_antinode = [first_antinode[0] + delta[0], first_antinode[1] + delta[1]]
  end
end

lines = File.readlines('input', chomp: true)
@map_length = lines.length
@map_width = lines[0].length
antennas = get_antennas_coordinates(lines)
antinodes = []

antennas.each do |_, antennas_coords|
  antennas_coords.each do |coordinates|
    unless antinodes.include? coordinates
      antinodes.append(coordinates)
    end
  end
end

antennas.each do |_, locations|
  locations.each_with_index do |first_antenna, index|
    locations[index + 1..].each do |second_antenna|
      delta = [first_antenna[0] - second_antenna[0], first_antenna[1] - second_antenna[1]]
      first_antinode = [first_antenna[0] + delta[0], first_antenna[1] + delta[1]]
      second_antinode = [second_antenna[0] - delta[0], second_antenna[1] - delta[1]]

      compute_antinodes_with_resonant_harmonics_effect(antinodes, delta, first_antinode)
      compute_antinodes_with_resonant_harmonics_effect(antinodes, delta.map { |n| n*(-1)}, second_antinode)
    end
  end
end

# should output 839
puts antinodes.length
