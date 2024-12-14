#!/usr/bin/ruby

def compute_min_tokens_needed(puzzle_input)
  total = 0
  tolerance = 0.0001
  machines = puzzle_input.split(/\n\n/)

  machines.each do |machine|
    groups = machine.scan(/\d+/)
    ax, ay, bx, by, x, y = groups.map { |arg| arg.to_i }
    a = (bx * y - by * x) / (bx * ay - by * ax).to_f
    b = (x - ax * a) / bx.to_f
    if (a - a.round).abs < tolerance and (b - b.round).abs < tolerance
      total += 3 * a + b
    end
  end
  total.round
end

input = File.read('input', chomp: true)
p1 = compute_min_tokens_needed(input)
# should output 29201
puts p1