#!/usr/bin/ruby

module Register
  A = 'A'
  B = 'B'
  C = 'C'
end

module ComboOperand
  ZERO = 0
  ONE = 1
  TWO = 2
  THREE = 3
  FOUR = 'A'
  FIVE = 'B'
  SIX = 'C'
end

class Computer
  attr_reader :registers
  attr_reader :program, :instruction_pointer

  def initialize(reg_a, reg_b, reg_c, program)
    @registers = Hash.new
    @registers[Register::A] = reg_a
    @registers[Register::B] = reg_b
    @registers[Register::C] = reg_c
    @program = program.chars.map { |c| c.to_i }
    @instruction_pointer = 0
  end

  def to_s
    "A: #{@registers[Register::A]}\nB: #{@registers[Register::B]}\nC: #{@registers[Register::C]}\nProgram: #{@program}"
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
