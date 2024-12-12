#!/usr/bin/ruby

@cache = Hash.new

def count(x, blinks = 75)
  if @cache.has_key? [x,blinks]
    return @cache[[x,blinks]]
  end

  if blinks == 0
    return 1
  end

  if x == 0
    result = count(1, blinks - 1)
    @cache[[1, blinks-1]] = result
    return result
  end

  length = Math.log10(x).to_i + 1

  if length % 2 == 1
    result = count(x * 2024, blinks - 1)
    @cache[[x*2024,blinks-1]] = result
    return result
  end

  result1 = count(x / 10 ** (length / 2), blinks - 1)
  result2 = count(x % 10 ** (length / 2), blinks - 1)

  @cache[[x / 10 ** (length / 2),blinks-1]] = result1
  @cache[[x % 10 ** (length / 2), blinks-1]] = result2
  @cache[[x,blinks]] = result1 + result2

  result1+result2
end

stones = File.read('input', chomp: true).split.map { |stone| stone.to_i }
# should output 232454623677743
puts stones.map { |stone| count(stone) }.sum
