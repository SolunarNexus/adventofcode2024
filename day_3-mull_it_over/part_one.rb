#!/usr/bin/ruby

mul_expressions = File.read('input').scan(/mul\(\d{1,3},\d{1,3}\)/)

puts "#{mul_expressions}"
puts "#{mul_expressions.length}"