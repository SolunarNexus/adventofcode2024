#!/usr/bin/ruby

wires = Hash.new
gates = Queue.new

wires_section, gates_section = File.read("input", chomp: true).split(/\n\n/)

wires_section.each_line(chomp: true) do |line|
  wire, value = line.scan(/([xy]\d\d): ([01])/)[0]
  wires[wire] = value.to_i
end

gates_section.each_line(chomp: true) do |line|
  wire_a, op, wire_b, _, out = line.split
  gates.push([wire_a, wire_b, op, out])
end

until gates.empty? do
  wire_a, wire_b, operator, out_wire = gates.pop

  if wires.has_key?(wire_a) && wires.has_key?(wire_b)
    case operator
    when "AND"
      wires[out_wire] = wires[wire_a] & wires[wire_b]
    when "OR"
      wires[out_wire] = wires[wire_a] | wires[wire_b]
    when "XOR"
      wires[out_wire] = wires[wire_a] ^ wires[wire_b]
    else
      raise("Invalid binary operator")
    end
  else
    gates.push([wire_a, wire_b, operator, out_wire])
  end
end

binary = wires.filter { |k, _| k.start_with?("z") }.sort_by { |k, _| k }.map { |_, v| v }.reverse!.join

puts "#{binary}"
# should output 58639252480880
puts "#{binary.to_i(2)}"