#!/usr/bin/ruby

left_lst = []
right_lst = []
occurrences = Hash.new(0)
similarity_score = 0

File.readlines('input', chomp: true).each do |line|
  parts = line.split
  left_lst.append(Integer(parts[0]))
  right_lst.append(Integer(parts[1]))
end

right_lst.each do |right|
  if occurrences.has_key? right
    occurrences[right] += 1
  else
    occurrences[right] = 1
  end
end

left_lst.each do |left|
  similarity_score += left * occurrences[left]
end

# should be 23529853
puts "#{similarity_score}"