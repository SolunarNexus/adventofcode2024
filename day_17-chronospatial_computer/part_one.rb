#!/usr/bin/ruby

class Computer
  attr_reader :reg_A, :reg_B, :reg_C, :program

  def initialize(reg_a, reg_b, reg_c, program)
    @reg_A, @reg_B, @reg_C, @program = reg_a, reg_b, reg_c, program
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
pc = Computer.new(*args)
puts pc