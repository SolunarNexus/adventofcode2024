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

def expand_trail_from(x, y, map, visited, prev, score)
  if is_out_of_map(map, x, y)
    return
  end
  if visited[y][x]
    return
  end

  current = map[y][x]

  if prev > current || current - prev != 1
    return
  end
  if map[y][x] == HIGHEST
    score.add([x, y])
    return
  end

  visited[y][x] = true

  expand_trail_from(x + 1, y, map, visited, current, score)
  expand_trail_from(x, y + 1, map, visited, current, score)
  expand_trail_from(x - 1, y, map, visited, current, score)
  expand_trail_from(x, y - 1, map, visited, current, score)
end

def explore_trails(trailheads, map)
  scores = Array.new

  trailheads.each do |head|
    achieved_tops = Set.new
    expand_trail_from(head[1], head[0], map, Array.new(map.length) { Array.new(map[0].length) { false } }, -1, achieved_tops)
    scores.append achieved_tops.count
  end
  scores
end

topographic_map = load_input('input')
trailheads_coords = locate_trailheads(topographic_map)
trail_scores = explore_trails(trailheads_coords, topographic_map)

# pretty_print_map(topographic_map)
# puts "#{trail_scores}"

# should output 789
puts trail_scores.sum
