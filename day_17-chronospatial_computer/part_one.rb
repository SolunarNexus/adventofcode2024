#!/usr/bin/ruby

module Register
  A = 'A'
  B = 'B'
  C = 'C'
end

class Computer
  attr_reader :registers
  attr_reader :program, :instruction_pointer, :output

  def initialize(reg_a, reg_b, reg_c, program)
    @registers = Hash.new
    @registers[Register::A] = reg_a
    @registers[Register::B] = reg_b
    @registers[Register::C] = reg_c
    @program = program.chars.filter { |c| c.match(/\d/) }.map { |c| c.to_i }
    @instruction_pointer = 0
    @output = Array.new
  end

  def get_combo_value_from(operand)
    case operand
    when 0..3
      return operand
    when 4
      return @registers[Register::A]
    when 5
      return @registers[Register::B]
    when 6
      return @registers[Register::C]
    else
      raise "Invalid operand #{operand} - allowed values are in range 0..6"
    end
  end

  def adv(operand)
    denominator = 2 ** get_combo_value_from(operand)
    @registers[Register::A] /= denominator
  end

  def bxl(operand)
    @registers[Register::B] ^= operand
  end

  def bst(operand)
    value = get_combo_value_from(operand)
    @registers[Register::B] = value % 8
  end

  def jnz(operand)
    unless @registers[Register::A] == 0
      @instruction_pointer = operand
    end
  end

  def bxc
    @registers[Register::B] ^= @registers[Register::C]
  end

  def out(operand)
    @output.append(get_combo_value_from(operand) % 8)
  end

  def to_s
    "A: #{@registers[Register::A]}\nB: #{@registers[Register::B]}\nC: #{@registers[Register::C]}\nProgram: #{@program}\nIP: #{@instruction_pointer}\nOutput: #{@output}\n"
  end
end

def load_input(filename)
  arguments = []
  File.readlines(filename, chomp: true).each do |line|
    arg = line.match(/(\d,?)+/)
    arguments.append arg[0] unless arg.nil?
  end
  arguments
end

args = load_input('input')
computer = Computer.new(*args)

puts computer
