#!/usr/bin/ruby

@cache = Hash.new

def load_input(filename)
  File.read('input', chomp: true).split.map { |stone| stone.to_i }
end

def stones_after_n_blinks(stone, blinks)
  if @cache.has_key? [stone, blinks]
    return @cache[[stone, blinks]]
  end

  if blinks == 0
    return 1
  end

  if stone == 0
    @cache[[1, blinks - 1]] = stones_after_n_blinks(1, blinks - 1)
    return @cache[[1, blinks - 1]]
  end

  length = Math.log10(stone).to_i + 1

  if length % 2 == 1
    @cache[[stone * 2024, blinks - 1]] = stones_after_n_blinks(stone * 2024, blinks - 1)
    return @cache[[stone * 2024, blinks - 1]]
  end

  @cache[[stone / 10 ** (length / 2), blinks - 1]] = stones_after_n_blinks(stone / 10 ** (length / 2), blinks - 1)
  @cache[[stone % 10 ** (length / 2), blinks - 1]] = stones_after_n_blinks(stone % 10 ** (length / 2), blinks - 1)
  @cache[[stone / 10 ** (length / 2), blinks - 1]] + @cache[[stone % 10 ** (length / 2), blinks - 1]]
end

# stones = load_input('input')
# should output 194482
# puts stones.map { |stone| stones_after_n_blinks(stone, 25) }.sum
