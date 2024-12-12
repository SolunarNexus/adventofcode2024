#!/usr/bin/ruby

require './part_one.rb'

stones = load_input('input')
# should output 232454623677743
puts stones.map { |stone| stones_after_n_blinks(stone, 75) }.sum
