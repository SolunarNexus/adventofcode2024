#!/usr/bin/ruby

disk_map = []
id = 0

File.read('test_input', chomp: true).each_char.with_index do |char, index|
  if char == '0'
    next
  end
  if index % 2 == 0
    disk_map.append [id] * Integer(char)
    id += 1
  else
    disk_map.append [nil] * Integer(char)
  end
end

left = 0
right = disk_map.length - 1
checksum = 0

while right >= 0
  # TODO
end

# puts "#{disk_map}"

# should output 6326952672104
puts checksum
