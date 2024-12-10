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

while right > 0
  left = 0
  while !disk_map[left][0].nil? && left < disk_map.length
    left += 1
  end

  file_size = disk_map[right].length

  while left < disk_map.length
    free_space_size = disk_map[left].length
    size_difference = free_space_size - file_size

    if size_difference == 0
      disk_map[left], disk_map[right] = disk_map[right], disk_map[left]
      break
    elsif size_difference > 0
      disk_map.delete_at(left)
      disk_map.insert(left, disk_map[right - 1])
      disk_map.insert(left + 1, [nil] * size_difference)
      disk_map[right + 1] = [nil] * file_size
      break
    end

    left += 1

    while left < disk_map.length && !disk_map[left][0].nil?
      left += 1
    end
  end

  if left == disk_map.length
    right -= 1
  end

  while right >= 0 && disk_map[right][0].nil?
    right -= 1
  end
end

puts "#{disk_map}"

# should output 6326952672104
puts checksum
