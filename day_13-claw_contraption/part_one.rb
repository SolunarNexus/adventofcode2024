#!/usr/bin/ruby

def get_claw_machines_specifications(input)
  specifications = []

  input.split(/\n\n/).each do |machine|
    groups = machine.scan(/\d+/)
    specifications.append groups.map { |arg| arg.to_i }
  end
  specifications
end

def min_token_amount(ax, ay, bx, by, x, y)
  tolerance = 0.0001
  a = (bx * y - by * x) / (bx * ay - by * ax).to_f
  b = (x - ax * a) / bx.to_f

  if (a - a.round).abs < tolerance and (b - b.round).abs < tolerance
    return 3 * a + b
  end
  0
end

def compute_min_tokens_needed(machines)
  total = 0

  machines.each do |ax, ay, bx, by, x, y|
    total += min_token_amount(ax, ay, bx, by, x, y)
  end
  total.round
end

# input = File.read('input', chomp: true)
# machines = get_claw_machines_specifications(input)
# tokens_total = compute_min_tokens_needed(machines)
#
# # should output 29201
# puts tokens_total