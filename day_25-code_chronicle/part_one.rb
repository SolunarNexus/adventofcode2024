#!/usr/bin/ruby

blocks = File.read("input").split(/\n\n/)
locks = Array.new
keys = Array.new

blocks.each do |block|
  columns = Array.new(5, -1)

  block.each_line(chomp: true) do |line|
    delta = line.chars.map { |c| c == '#' ? 1 : 0 }
    columns = [columns, delta].transpose.map(&:sum)
  end

  if block.start_with? '#'
    locks.append(columns)
  else
    keys.append(columns)
  end
end

fits = 0

locks.each do |lock|
  keys.each do |key|
    combination = [lock, key].transpose.map(&:sum)
    fits += combination.any? {|e| e > 5} ? 0 : 1
  end
end

# should output 3116
puts fits