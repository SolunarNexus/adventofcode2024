#!/usr/bin/ruby

class Stone
  attr_accessor :number, :next

  def initialize(num = nil, successor = nil)
    @number = num
    @next = successor
  end

  def insert(number)
    if self.next.nil?
      self.next = Stone.new(number)
    else
      new_one = Stone.new(number)
      self.next, new_one.next = new_one, self.next
    end
  end

  def to_s
    str = ""
    node = self
    loop do
      str += node.number.to_s
      break if node.next.nil?
      str += ' '
      node = node.next
    end
    str
  end
end

def blink(stone)
  stones_count = 0

  until stone.nil?
    if stone.number == 0
      stone.number = 1
    elsif (length = Math.log10(stone.number).to_i + 1) % 2 == 0
      left_half = stone.number / (10 ** (length/2))
      right_half = stone.number % (10 ** (length/2))
      stone.number = left_half
      stone.insert(right_half)
      stone = stone.next
      stones_count += 1
    else
      stone.number = stone.number * 2024
    end
    stones_count += 1
    stone = stone.next
  end
  stones_count
end

def blink_n_times(stones, n)
  stones_count = nil
  n.times do |i|
    stones_count = blink(stones)
    puts "#{i}: #{stones_count}"
  end
  stones_count
end

stone = Stone.new
head = stone
numbers = File.read('input', chomp: true).split

numbers[1..-1].each.with_index(1) do |number, index|
  stone.number = numbers[index-1].to_i
  stone.next = Stone.new(number.to_i, nil)
  stone = stone.next
end

puts blink_n_times(head, 75)
puts head