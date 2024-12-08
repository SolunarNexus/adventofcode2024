#!/usr/bin/ruby

module DIRECTION
  UP = [-1, 0]
  DOWN = [1, 0]
  RIGHT = [0, 1]
  LEFT = [0, -1]
end

def find_patrol_guard(lab)
  lab.each_with_index do |line, row_index|
    column_index = line.index('^')
    unless column_index.nil?
      return [row_index, column_index]
    end
  end
end

def is_guard_in_lab(position, length, width)
  position[0] >= 0 && position[0] < length && position[1] >= 0 && position[1] < width
end

def turn_right(direction)
  case direction
  when DIRECTION::UP
    return DIRECTION::RIGHT
  when DIRECTION::RIGHT
    return DIRECTION::DOWN
  when DIRECTION::DOWN
    return DIRECTION::LEFT
  when DIRECTION::LEFT
    return DIRECTION::UP
  else
    return nil
  end
end

def move_guard(lab, position, direction)
  next_position = [position[0] + direction[0], position[1] + direction[1]]

  if !lab[next_position[0]].nil? && lab[next_position[0]][next_position[1]] == "#"
    new_direction = turn_right(direction)
    return move_guard(lab, position, new_direction)
  end

  [next_position, direction]
end

def mark_visited_positions(lab, visited_positions)
  visited_positions.each do |position|
    lab[position[0]][position[1]] = 'X'
  end
end

def load_lab(file_name)
  lab = Array.new
  File.readlines(file_name, chomp: true).each do |line|
    lab.append(line)
  end
  lab
end

lab = load_lab('input')
visited_positions = Set.new
lab_length = lab.length
lab_width = lab[0].length
initial_guard_position = find_patrol_guard(lab)
initial_direction = DIRECTION::UP
guard_position = initial_guard_position
direction = initial_direction

loop do
  visited_positions.add(guard_position)
  guard_position, direction = move_guard(lab, guard_position, direction)
  break if !is_guard_in_lab(guard_position, lab_length, lab_width) || (guard_position == initial_guard_position && direction == initial_direction)
end

# should output 5095
puts "#{visited_positions.length}"
