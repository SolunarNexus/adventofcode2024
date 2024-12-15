#!/usr/bin/ruby

require './part_one.rb'

def tiles_to_s(tiles)
  grid = ""
  tiles.each do |line|
    grid += line.each.map { |tile| tile == 0 ? '.' : tile }.join('')
    grid += "\n"
  end
  grid
end

def find_easter_egg(robots, space_width = 101, space_length = 103)
  10001.times do |seconds|
    tiles_with_robots = robot_amount_on_each_tile(robots, space_width, space_length, seconds)
    grid = tiles_to_s(tiles_with_robots)

    if grid.include? "11111111"
      # puts grid
      return seconds
    end
  end
end

robots = get_robots_from_input('input')
seconds_until_easter_egg = find_easter_egg(robots)

# should output 7847
puts seconds_until_easter_egg