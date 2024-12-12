#!/usr/bin/ruby

@cache = Hash.new

def count(stone_number, blinks = 75)
  if @cache.has_key? [stone_number,blinks]
    return @cache[[stone_number,blinks]]
  end

  if blinks == 0
    return 1
  end

  if stone_number == 0
    result = count(1, blinks - 1)
    @cache[[1, blinks-1]] = result
    return result
  end

  length = Math.log10(stone_number).to_i + 1

  if length % 2 == 1
    result = count(stone_number * 2024, blinks - 1)
    @cache[[stone_number*2024,blinks-1]] = result
    return result
  end

  result1 = count(stone_number / 10 ** (length / 2), blinks - 1)
  result2 = count(stone_number % 10 ** (length / 2), blinks - 1)

  @cache[[stone_number / 10 ** (length / 2),blinks-1]] = result1
  @cache[[stone_number % 10 ** (length / 2), blinks-1]] = result2
  @cache[[stone_number,blinks]] = result1 + result2

  result1+result2
end

stones = File.read('input', chomp: true).split.map { |stone| stone.to_i }
# should output 232454623677743
puts stones.map { |stone| count(stone) }.sum
