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

def robot_amount_on_each_tile(robots, space_width = 101, space_length = 103, seconds = 100)
  space = Array.new(space_length) { Array.new(space_width, 0) }

  robots.each do |robot|
    end_x, end_y = robot_position_after_n_seconds(robot, space_width, space_length, seconds)
    space[end_y][end_x] += 1
  end
  space
end

def get_amount_of_robots_in_quadrants(tiles, width = 101, length = 103)
  quadrants = Array.new(4, 0)
  vertical_mid_axis_pos = width / 2 - 1
  horizontal_mid_axis = length / 2 - 1
  horizontal_jump = width % 2 == 1 ? 2 : 1
  vertical_jump = length % 2 == 1 ? 2 : 1

  quadrant1 = (0..horizontal_mid_axis).collect { |i| tiles[i][0..vertical_mid_axis_pos] }
  quadrant2 = (0..horizontal_mid_axis).collect { |i| tiles[i][vertical_mid_axis_pos + horizontal_jump..] }
  quadrant3 = (horizontal_mid_axis + vertical_jump..length - 1).collect { |i| tiles[i][0..vertical_mid_axis_pos] }
  quadrant4 = (horizontal_mid_axis + vertical_jump..length - 1).collect { |i| tiles[i][vertical_mid_axis_pos + vertical_jump..] }
  quadrants[0] = quadrant1.map { |row| row.sum }.sum
  quadrants[1] = quadrant2.map { |row| row.sum }.sum
  quadrants[2] = quadrant3.map { |row| row.sum }.sum
  quadrants[3] = quadrant4.map { |row| row.sum }.sum
  quadrants
end

def get_safety_factor(quadrants)
  quadrants.inject(:*)
end

robots = get_robots_from_input('input')
tiles_w_robot_count = robot_amount_on_each_tile(robots)
robots_in_quadrants = get_amount_of_robots_in_quadrants(tiles_w_robot_count)
safety_factor = get_safety_factor(robots_in_quadrants)

puts "#{tiles_w_robot_count}"
puts "#{robots_in_quadrants}"

# should output 225648864
puts safety_factor
