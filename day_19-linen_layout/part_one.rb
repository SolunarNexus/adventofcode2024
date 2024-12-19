#!/usr/bin/ruby

def load_input(filename)
  input = File.read(filename, chomp: true).split(/\n\n/)
  towel_patterns = input[0].split(/, /)
  combinations = input[1].split(/\n/)
  [towel_patterns, combinations]
end

def is_possible(patterns, combination)
  if combination.nil? || patterns.empty?
    return false
  end
  if combination.length == 0
    return true
  end

  viable_patterns = patterns.filter {|pattern| combination.start_with?(pattern)}

  return viable_patterns.map {|pattern| is_possible(patterns, combination.sub(pattern, ""))}.include?(true)
end

def possible_combinations(patterns, combinations)
  total = 0

  combinations.each do |combination|
    total += 1 if is_possible(patterns, combination)
  end
  total
end

towel_patterns, combinations = load_input 'input'

total = possible_combinations(towel_patterns, combinations)

puts total