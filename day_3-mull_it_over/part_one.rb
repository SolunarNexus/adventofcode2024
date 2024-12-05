#!/usr/bin/ruby

mul_expressions = File.read('input').scan(/mul\(\d{1,3},\d{1,3}\)/)
sum = 0

mul_expressions.each_with_index do |expr|
  arg1, arg2 = expr.match(/\((\d{1,3}),(\d{1,3})\)/).captures.map { |g| Integer(g) }
  sum += arg1 * arg2
end

# should output 166905464
puts "#{sum}"