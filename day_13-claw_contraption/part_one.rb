#!/usr/bin/ruby

def get_claw_machines_specifications(input)
  specifications = []

  input.split(/\n\n/).each do |machine|
    groups = machine.scan(/\d+/)
    specifications.append groups.map { |arg| arg.to_i }
  end
  specifications
end

def compute_min_tokens_needed(machines)
  total = 0
  tolerance = 0.0001

  machines.each do |ax, ay, bx, by, x, y|
    a = (bx * y - by * x) / (bx * ay - by * ax).to_f
    b = (x - ax * a) / bx.to_f
    if (a - a.round).abs < tolerance and (b - b.round).abs < tolerance
      total += 3 * a + b
    end
  end
  total.round
end

input = File.read('input', chomp: true)
machines = get_claw_machines_specifications(input)
p1 = compute_min_tokens_needed(machines)
# should output 29201
puts p1