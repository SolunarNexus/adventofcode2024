#!/usr/bin/ruby

disk_map = []
id = 0

File.read('input', chomp: true).each_char.with_index do |char, index|
  if index % 2 == 0
    disk_map.concat([id] * Integer(char))
    id += 1
  else
    disk_map.concat([nil] * Integer(char))
  end
end

left = 0
right = disk_map.length - 1
checksum = 0

while left <= right
  if disk_map[left].nil?
    disk_map[left], disk_map[right] = disk_map[right], disk_map[left]
    while disk_map[right].nil?
      right -= 1
    end
  end

  checksum += left * Integer(disk_map[left])

  left += 1
end

# should output 6299243228569
puts checksum
