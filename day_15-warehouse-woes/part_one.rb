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

def try_move_boxes(x, y, instruction, map)
  diff = [0, 0]

  case instruction
  when '^'
    diff[1] -= 1
  when '>'
    diff[0] += 1
  when '<'
    diff[0] -= 1
  when 'v'
    diff[1] += 1
  else
    throw Exception("Invalid instruction: #{instruction}")
  end

  while true
    x += diff[0]
    y += diff[1]

    if map[y][x] == Warehouse::EMPTY
      map[y][x] = Warehouse::BOX
      return true
    elsif map[y][x] == Warehouse::WALL
      return false
    end
  end
end

def move_robot(origin, instruction, map)
  to_position = [origin[0], origin[1]]

  case instruction
  when '^'
    to_position[1] -= 1
  when '>'
    to_position[0] += 1
  when '<'
    to_position[0] -= 1
  when 'v'
    to_position[1] += 1
  else
    throw Exception("Invalid instruction: #{instruction}")
  end

  x = to_position[0]
  y = to_position[1]

  if map[y][x] == Warehouse::WALL
    return origin
  end
  if map[y][x] == Warehouse::EMPTY
    map[origin[1]][origin[0]], map[y][x] = map[y][x], map[origin[1]][origin[0]]
    return to_position
  end
  if map[y][x] == Warehouse::BOX && try_move_boxes(x, y, instruction, map)
    map[origin[1]][origin[0]] = Warehouse::EMPTY
    map[y][x] = '@'
    return to_position
  end
  origin
end

def process_instructions(from_position, instructions, map)
  instructions.each_char do |instruction|
    from_position = move_robot(from_position, instruction, map)
  end
end

map, instructions, robot = load_input('test_input2')

puts map
puts "#{instructions}"
process_instructions(robot, instructions, map)
puts map
