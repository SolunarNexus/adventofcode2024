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

pc = Computer.new(1, 2, 4, "0,1,0,2")
puts pc