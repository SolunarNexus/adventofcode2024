#!/usr/bin/ruby

@cache = Hash.new

def count(x, d = 75)
  if @cache.has_key? [x,d]
    return @cache[[x,d]]
  end

  if d == 0
    return 1
  end

  if x == 0
    result = count(1, d - 1)
    @cache[[1, d-1]] = result
    return result
  end

  length = Math.log10(x).to_i + 1

  if length % 2 == 1
    result = count(x * 2024, d - 1)
    @cache[[x*2024,d-1]] = result
    return result
  end

  result1 = count(x / 10 ** (length / 2), d - 1)
  result2 = count(x % 10 ** (length / 2), d - 1)

  @cache[[x / 10 ** (length / 2),d-1]] = result1
  @cache[[x % 10 ** (length / 2), d-1]] = result2
  @cache[[x,d]] = result1 + result2

  result1+result2
end

stones = File.read('input', chomp: true).split.map { |stone| stone.to_i }
# should output 232454623677743
puts stones.map { |stone| count(stone) }.sum
