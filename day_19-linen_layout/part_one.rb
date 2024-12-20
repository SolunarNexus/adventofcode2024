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

  until viable_patterns.empty?
    pattern = viable_patterns.pop

    if is_possible(patterns, combination.sub(pattern, ""))
      return true
    end
  end
end

def possible_combinations(patterns, designs)
  total = 0

  designs.each do |design|
    total += 1 if is_possible(patterns, design)
  end
  total
end

towel_patterns, combinations = load_input 'input'
total = possible_combinations(towel_patterns, combinations)
# should output 240
puts total