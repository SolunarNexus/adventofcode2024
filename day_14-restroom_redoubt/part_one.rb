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
    x, y, dx, dy = line.scan(pattern).map { |arg| arg.to_i }
    robots.append Robot.new(x, y, dx, dy)
  end
  robots
end

def robot_position_after_n_seconds(robot, space_width, space_length, seconds = 100)
  [(robot.get_start_pos_x + robot.get_velocity_dx * seconds) % space_width,
   (robot.get_start_pos_y + robot.get_velocity_dy * seconds) % space_length]
end

def robot_amount_on_each_tile(robots, space_width, space_length, seconds = 100)
  space = Array.new(space_length) { Array.new(space_width, 0) }

  robots.each do |robot|
    end_x, end_y = robot_position_after_n_seconds(robot, space_width, space_length, seconds)
    space[end_y][end_x] += 1
  end
  space
end

robots = get_robots_from_input('test_input')
tiles_w_robot_count = robot_amount_on_each_tile(robots, 11, 7, 100)
puts "#{tiles_w_robot_count}"