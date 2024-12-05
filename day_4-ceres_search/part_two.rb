#!/usr/bin/ruby

@lines = File.readlines('test_input', chomp: true)
@lines_count = @lines.length
@line_length = @lines[0].length
xmas = 0

module DIAGONAL
  FIRST = [-1, -1]
  SECOND = [-1, 1]
end

def valid_line_index(line_idx)
  line_idx >= 1 && line_idx < @lines_count - 1
end

def valid_char_index(char_idx)
  char_idx >= 1 && char_idx < @line_length - 1
end

def get_chars_from_diagonal_ends(line_idx, char_idx, direction)
  [@lines[line_idx - direction[0]][char_idx - direction[1]], @lines[line_idx - (-direction[0])][char_idx - (-direction[1])]]
end

def valid_diagonal(line_idx, char_idx, direction)
  unless valid_line_index(line_idx) && valid_char_index(char_idx)
    return false
  end

  first_char, opposite_char = get_chars_from_diagonal_ends(line_idx, char_idx, direction)

  if first_char == 'M' && opposite_char == 'S' || first_char == 'S' && opposite_char == 'M'
    return true
  end

  false
end

def contains_xmas_pattern(line_idx, char_idx)
  valid_diagonal(line_idx, char_idx, DIAGONAL::FIRST) && valid_diagonal(line_idx, char_idx, DIAGONAL::SECOND)
end

@lines.each_with_index do |line, line_idx|
  line.each_char.with_index do |char, char_idx|

    if char == 'A' && contains_xmas_pattern(line_idx, char_idx)
      xmas += 1
    end
  end
end

# should output 2000
puts "#{xmas}"