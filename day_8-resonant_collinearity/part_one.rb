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

lines = File.readlines('input', chomp: true)
@map_length = lines.length
@map_width = lines[0].length
antinodes = []
antennas = get_antennas_coordinates(lines)

antennas.each do |_, locations|
  locations.each_with_index do |first_antenna, index|
    locations[index + 1..].each do |second_antenna|
      delta = [first_antenna[0] - second_antenna[0], first_antenna[1] - second_antenna[1]]
      first_antinode = [first_antenna[0] + delta[0], first_antenna[1] + delta[1]]
      second_antinode = [second_antenna[0] - delta[0], second_antenna[1] - delta[1]]

      if !antinodes.include?(first_antinode) && is_within_bounds(first_antinode)
        antinodes.append(first_antinode)
      end
      if !antinodes.include?(second_antinode) && is_within_bounds(second_antinode)
        antinodes.append(second_antinode)
      end
    end
  end
end

# should output 252
puts antinodes.length
