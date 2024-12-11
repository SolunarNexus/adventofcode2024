#!/usr/bin/ruby

def load_input(filename)
  disk_map = []
  id = 0

  File.read(filename, chomp: true).each_char.with_index do |char, index|
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
  disk_map
end

def find_free_block(disk_map, left = 0)
  while !disk_map[left][0].nil? && left < disk_map.length
    left += 1
  end
  left
end

def find_file_block(disk_map, left, right)
  if left >= right
    right -= 1
  end

  while right >= 0 && disk_map[right][0].nil?
    right -= 1
  end
  right
end

def move_file_block(disk_map, file_size, left, right, size_difference)
  if size_difference == 0
    disk_map[left], disk_map[right] = disk_map[right], disk_map[left]
  elsif size_difference > 0
    disk_map.delete_at(left)
    disk_map.insert(left, disk_map[right - 1])
    disk_map.insert(left + 1, [nil] * size_difference)
    disk_map[right + 1] = [nil] * file_size
  end
end

def try_fit_file_block_in_some_free_block(disk_map, file_size, left, right)
  while left < right
    free_space_size = disk_map[left].length
    size_difference = free_space_size - file_size

    if size_difference >= 0
      move_file_block(disk_map, file_size, left, right, size_difference)
      break
    end

    left = find_free_block(disk_map, left + 1)
  end
  left
end

def inspect_all_file_blocks(disk_map, right)
  while right > 0
    left = find_free_block(disk_map)
    file_size = disk_map[right].length

    left = try_fit_file_block_in_some_free_block(disk_map, file_size, left, right)

    right = find_file_block(disk_map, left, right)
  end
end

def move_file_block_front(disk_map)
  right = disk_map.length - 1
  inspect_all_file_blocks(disk_map, right)
end

def compute_checksum(disk_map)
  checksum = 0

  disk_map.each_with_index do |block, index|
    unless block.nil?
      checksum += index * block
    end
  end
  checksum
end

disk_map = load_input('input')
move_file_block_front(disk_map)
checksum = compute_checksum(disk_map.flatten)

# should output 6326952672104
puts checksum
