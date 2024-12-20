#!/usr/bin/ruby
require './part_one.rb'

def possible_combinations(patterns, designs)
  total = 0

  designs.each do |design|
    total += all_combinations(patterns, design)
  end
  total
end

def all_combinations(patterns, design)
  viable_patterns = patterns.select { |e| design.include?(e) }
  dp = Array.new(design.length + 1, 0)
  dp[0] = 1

  (1..design.length).each do |i|
    viable_patterns.each do |pattern|
      if i >= pattern.length && design[i - pattern.length...i] == pattern
        dp[i] += dp[i - pattern.length]
      end
    end
  end

  dp[design.length]
end

towel_patterns, combinations = load_input 'input'
total = possible_combinations(towel_patterns, combinations)
# should output 848076019766013
puts total