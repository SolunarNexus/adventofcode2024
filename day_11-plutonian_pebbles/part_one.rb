#!/usr/bin/ruby

def blink(stones)
  stones_after_blink = []

  stones.each do |stone_number|
    if stone_number == '0'
      stones_after_blink.append '1'
    elsif stone_number.length % 2 == 0
      stones_after_blink.append stone_number[0..stone_number.length/2-1]
      stones_after_blink.append stone_number[stone_number.length/2..].to_i.to_s
    else
      stones_after_blink.append (Integer(stone_number) * 2024).to_s
    end
  end
  stones_after_blink
end

def blink_n_times(stones, n)
  # stones_copy = Marshal.load(Marshal.dump(stones))

  n.times do |i|
    stones = blink(stones)
    puts "#{i}: #{stones.length}"
  end
  stones
end

stones = File.read('input', chomp:true).split

# after_25_blinks = blink_n_times(stones, 25)
after_75_blinks = blink_n_times(stones, 75)

puts after_25_blinks.length
