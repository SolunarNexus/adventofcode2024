#!/usr/bin/ruby

HIGHEST = 9
LOWEST = 0

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
      if position == LOWEST
        trailheads.append [line_idx, position_idx]
      end
    end
  end
  trailheads
end

def pretty_print_map(topographic_map)
  topographic_map.each do |line|
    puts line.join(' ')
  end
end

def is_out_of_map(map, x, y)
  x < 0 || x >= map[0].length || y < 0 || y >= map.length
end

def is_downhill(current, prev)
  prev > current
end

def not_gradual(current, prev)
  current - prev != 1
end

def expand_trail_from(x, y, map, visited, prev)
  if is_out_of_map(map, x, y) || visited[y][x]
    return 0
  end

  current = map[y][x]

  if is_downhill(current, prev) || not_gradual(current, prev)
    return 0
  end
  if map[y][x] == HIGHEST
    return 1
  end

  # visited[y][x] = true

  expand_trail_from(x + 1, y, map, visited, current) +
  expand_trail_from(x, y + 1, map, visited, current) +
  expand_trail_from(x - 1, y, map, visited, current) +
  expand_trail_from(x, y - 1, map, visited, current)
end

def explore_trails(trailheads, map)
  ratings = Array.new

  trailheads.each do |head|
    ratings.append expand_trail_from(head[1], head[0], map, Array.new(map.length) { Array.new(map[0].length) { false } }, -1)
  end
  ratings
end

topographic_map = load_input('input')
trailheads_coords = locate_trailheads(topographic_map)
trail_scores = explore_trails(trailheads_coords, topographic_map)

# pretty_print_map(topographic_map)
puts "#{trail_scores}"

# should output 1735
puts trail_scores.sum
