#!/usr/bin/ruby

def load_input(filename)
  input = File.read(filename, chomp: true).split(/\n\n/)
  towel_patterns = input[0].split(/, /)
  combinations = input[1].split(/\n/)
  [towel_patterns, combinations]
end

towel_patterns, combinations = load_input 'test_input'

puts "#{towel_patterns}"
puts "#{combinations}"