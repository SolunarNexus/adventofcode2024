#!/usr/bin/ruby

module Register
  A = 'A'
  B = 'B'
  C = 'C'
end

module Opcode
  ADV = 0
  BXL = 1
  BST = 2
  JNZ = 3
  BXC = 4
  OUT = 5
  BDV = 6
  CDV = 7
end

class Computer
  attr_reader :registers, :program, :instruction_pointer, :output

  def initialize(reg_a, reg_b, reg_c, program)
    @registers = Hash.new
    @registers[Register::A] = reg_a.to_i
    @registers[Register::B] = reg_b.to_i
    @registers[Register::C] = reg_c.to_i
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
    @registers[Register::A] = divide(operand)
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

  def bdv(operand)
    @registers[Register::B] = divide(operand)
  end

  def cdv(operand)
    @registers[Register::C] = divide(operand)
  end

  def divide(operand)
    @registers[Register::A] / (2 ** get_combo_value_from(operand))
  end

  def run
    until @program[@instruction_pointer].nil?
      opcode = @program[@instruction_pointer]
      operand = @program[@instruction_pointer + 1]

      case opcode
      when Opcode::ADV
        adv(operand)
      when Opcode::BXL
        bxl(operand)
      when Opcode::BST
        bst(operand)
      when Opcode::JNZ
        prev_ip = @instruction_pointer
        jnz(operand)

        if prev_ip != @instruction_pointer
          next
        end
      when Opcode::BXC
        bxc
      when Opcode::OUT
        out(operand)
      when Opcode::BDV
        bdv(operand)
      when Opcode::CDV
        cdv(operand)
      else
        raise "Invalid instruction #{opcode} - valid values are in range 0..7"
      end

      @instruction_pointer += 2
    end
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

# args = load_input('input')
# computer = Computer.new(*args)
# computer.run
#
# # should output 7,4,2,5,1,4,6,0,4
# puts "#{computer.output.join(',')}"
