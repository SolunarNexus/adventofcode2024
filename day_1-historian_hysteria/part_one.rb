#!/usr/bin/env/ruby

left_lst = []
right_lst = []
diff = []

File.readlines('input', chomp: true).each do |line|
  parts = line.split
  left_lst.append(Integer(parts[0]))
  right_lst.append(Integer(parts[1]))
end

puts "#{left_lst}"
left_lst.sort!
right_lst.sort!
puts "#{left_lst}"

left_lst.zip(right_lst).each do |left, right|
  diff.append((right-left).abs)
end

# should be 1388114
puts diff.sum
