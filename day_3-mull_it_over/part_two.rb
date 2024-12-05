#!/usr/bin/ruby

patterns = [/mul\(\d{1,3},\d{1,3}\)/, /don't\(\)/, /do\(\)/]
re = Regexp.union(patterns)
expressions = File.read('input').scan(re)
sum = 0
multiplication_enabled = true

expressions.each_with_index do |expr|
  if expr == "do()"
    multiplication_enabled = true
  elsif expr == "don't()"
    multiplication_enabled = false
  elsif multiplication_enabled
    arg1, arg2 = expr.match(/\((\d{1,3}),(\d{1,3})\)/).captures.map { |g| Integer(g) }
    sum += arg1 * arg2
  end
end

# should output 72948684
puts "#{sum}"