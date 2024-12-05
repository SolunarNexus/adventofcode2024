#!/usr/bin/ruby

@lines = File.readlines('input', chomp: true)
@lines_count = @lines.length
@line_length = @lines[0].length
@grammar = { "init" => "X", "X" => "M", "M" => "A", "A" => "S", "S" => "end" }
@expected = @grammar["init"]
@xmas = 0

module Direction
  RIGHT = [0, 1]
  LEFT = [0, -1]
  UP = [-1, 0]
  DOWN = [1, 0]
  DIAGONAL_UP_RIGHT = [-1, 1]
  DIAGONAL_UP_LEFT = [-1, -1]
  DIAGONAL_DOWN_RIGHT = [1, 1]
  DIAGONAL_DOWN_LEFT = [1, -1]
end

def valid_line_index(line_idx)
  line_idx >= 0 && line_idx < @lines_count
end

def valid_char_index(char_idx)
  char_idx >= 0 && char_idx < @line_length
end

def is_expected_char(line_idx, char_idx)
  @lines[line_idx][char_idx] == @expected
end

def scan_single_direction(line_idx, char_idx, direction)
  while valid_line_index(line_idx) && valid_char_index(char_idx) && is_expected_char(line_idx, char_idx)
    @expected = @grammar[@expected]
    char_idx += direction[0]
    line_idx += direction[1]
  end

  if @expected == "end"
    @xmas += 1
  end

  @expected = @grammar["init"]
end

def scan_directions(line_idx, char_idx)
  scan_single_direction(line_idx, char_idx,Direction::RIGHT)
  scan_single_direction(line_idx, char_idx, Direction::LEFT)
  scan_single_direction(line_idx, char_idx, Direction::UP)
  scan_single_direction(line_idx, char_idx, Direction::DOWN)
  scan_single_direction(line_idx, char_idx, Direction::DIAGONAL_UP_RIGHT)
  scan_single_direction(line_idx, char_idx, Direction::DIAGONAL_UP_LEFT)
  scan_single_direction(line_idx, char_idx, Direction::DIAGONAL_DOWN_RIGHT)
  scan_single_direction(line_idx, char_idx, Direction::DIAGONAL_DOWN_LEFT)
end

@lines.each_with_index do |line, line_idx|
  line.each_char.with_index do |char, char_idx|
    if char == @expected
      scan_directions(line_idx, char_idx)
    end
  end
end

# should output 2646
puts "#{@xmas}"