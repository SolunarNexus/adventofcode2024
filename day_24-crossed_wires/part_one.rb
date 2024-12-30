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

  unless wires.has_key?(wire_a) && wires.has_key?(wire_b)
    gates.push([wire_a, wire_b, operator, out_wire])
  else
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
  end
end

binary = wires.entries.filter {|k, _| k.start_with?("z")}.sort_by {|k, _| -k}.map { |_, v| v}.reverse!.join

puts "#{binary}"
puts "#{binary.to_i(2)}"