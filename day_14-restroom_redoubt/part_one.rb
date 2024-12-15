#!/usr/bin/ruby

class Robot
  attr_accessor :start_position
  attr_accessor :velocity

  def initialize(x, y, dx, dy)
    @start_position = [x, y]
    @velocity = [dx, dy]
  end

  def get_start_pos_x
    @start_position[0]
  end

  def get_start_pos_y
    @start_position[1]
  end

  def get_velocity_dx
    @velocity[0]
  end

  def get_velocity_dy
    @velocity[1]
  end

  def to_s
    "p=#{@start_position[0]},#{@start_position[1]} v=#{@velocity[0]},#{@velocity[1]}"
  end
end

def get_robots_from_input(filename)
  pattern = /-?\d+/
  robots = Array.new

  File.readlines(filename).each do |line|
    x, y, dx, dy = line.scan(pattern)
    robots.append Robot.new(x, y, dx, dy)
  end
  robots
end

robots = get_robots_from_input('test_input')
puts robots