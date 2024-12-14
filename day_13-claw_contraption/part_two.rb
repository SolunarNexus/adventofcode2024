#!/usr/bin/ruby

require './part_one.rb'

def compute_min_tokens_needed(machines, offset = 0)
  total = 0
  tolerance = 0.0001

  machines.each do |ax, ay, bx, by, x, y|
    x += offset
    y += offset
    total += min_token_amount(ax, ay, bx, by, tolerance, x, y)
  end
  total.round
end

input = File.read('input', chomp: true)
machines_specifications = get_claw_machines_specifications(input)
tokens_total = compute_min_tokens_needed(machines_specifications, 10_000_000_000_000)

# should output 104140871044942
puts tokens_total