#!/usr/bin/ruby

def next_secret(secret)
  secret = (secret ^ (secret << 6)) & 0xFFFFFF
  secret = (secret ^ (secret >> 5)) & 0xFFFFFF
  (secret ^ (secret << 11)) & 0xFFFFFF
end

secrets = File.readlines('input', chomp: true).map(&:to_i)
sales = Hash.new(0)

secrets.each do |secret|
  seen = Set.new
  diffs = 0

  4.times do
    old_price = secret % 10
    secret = next_secret(secret)
    new_price = secret % 10
    # adjust range from (-9, 9) to (0, 18)
    diffs = (diffs << 5) + (new_price - old_price + 9)
  end

  seen << diffs
  sales[diffs] += secret % 10

  1996.times do
    old_price = secret % 10
    secret = next_secret(secret)
    new_price = secret % 10

    # take lowest 15 bits
    diffs = ((diffs & 0x7FFF) << 5) + (new_price - old_price + 9)
    sales[diffs] += new_price unless seen.include?(diffs)
    seen << diffs
  end
end

puts sales.values.max