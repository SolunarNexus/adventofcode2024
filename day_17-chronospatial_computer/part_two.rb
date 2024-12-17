#!/usr/bin/ruby

require './part_one.rb'

class Computer
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

        if @output.last != @program[@output.length-1]
          return
        end
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

  def reinitialize(reg_a, reg_b, reg_c, program)
    @registers[Register::A] = reg_a
    @registers[Register::B] = reg_b
    @registers[Register::C] = reg_c
    @program = program
    @output.clear
    @instruction_pointer = 0
  end
end

def delta(n)
  2 ** (3 * n)
end

def find_lowest_value_to_output_program_copy(computer, reg_b, reg_c, program)
  reg_a = delta(computer.program.length - 1)

  (computer.program.length-1).downto(0) do |i|
    while true
      computer.reinitialize(reg_a, reg_b, reg_c, program)
      computer.run

      if computer.program == computer.output
        return reg_a
      end
      if computer.program[i] == computer.output[i]
        break
      end
      reg_a += delta(i)
    end
  end
  -1
end

# TODO: reverse engineer this
# g = list( map( int, open( 'input' ).read().split()[ -1 ].split( ',' ) ) )
#
# def solve( p, r ):
#   if p < 0:
#     print( r )
#   return True
#   for d in range( 8 ):
#     a, i = r << 3 | d, 0
#     while i < len( g ):
#       if   g[ i + 1 ] <= 3: o = g[ i + 1 ]
#       elif g[ i + 1 ] == 4: o = a
#       elif g[ i + 1 ] == 5: o = b
#       elif g[ i + 1 ] == 6: o = c
#       if   g[ i ] == 0: a >>= o
#       elif g[ i ] == 1: b  ^= g[ i + 1 ]
#       elif g[ i ] == 2: b   = o & 7
#       elif g[ i ] == 3: i   = g[ i + 1 ] - 2 if a != 0 else i
#       elif g[ i ] == 4: b  ^= c
#       elif g[ i ] == 5: w   = o & 7; break
#       elif g[ i ] == 6: b   = a >> o
#       elif g[ i ] == 7: c   = a >> o
#       i += 2
#       if w == g[ p ] and solve( p - 1, r << 3 | d ):
#         return True
#       return False
#
#       solve( len( g ) - 1, 0 )

args = load_input('input')
computer = Computer.new(*args)
value = find_lowest_value_to_output_program_copy(computer, computer.registers[Register::B], computer.registers[Register::C], computer.program)

# should output 164278764924605
puts value