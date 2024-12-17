#!/usr/bin/ruby

module ComboOperands
  ZERO = 0
  ONE = 1
  TWO = 2
  THREE = 3
  FOUR = 'A'
  FIVE = 'B'
  SIX = 'C'
end

class Computer
  attr_reader :reg_A, :reg_B, :reg_C, :program, :instruction_pointer

  def initialize(reg_a, reg_b, reg_c, program)
    @reg_A, @reg_B, @reg_C = reg_a, reg_b, reg_c
    @program = program.chars.map {|c| c.to_i}
    @instruction_pointer = 0
  end

  def to_s
    "A: #{reg_A}\nB: #{reg_B}\nC: #{reg_C}\nProgram: #{program}"
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

