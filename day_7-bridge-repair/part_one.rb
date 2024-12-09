#!/usr/bin/ruby

def load_input(file_name)
  equations = Array.new

  File.readlines(file_name, chomp: true).each do |line|
    parts = line.split(/:/)
    test_value = Integer(parts[0])
    parameters = parts[1].chomp.split.map { |part| Integer(part) }

    unless equations.find(lambda {return nil}) { |e| e == test_value }.nil?
      puts test_value
    end
    equations.append([test_value, parameters])
  end
  equations
end

def has_equation_solution(test_value, parameters, current_value)
  if current_value > test_value
    return false
  end
  if parameters.empty?
    if current_value == test_value
      return true
    end
    return false
  end

  has_equation_solution(test_value, parameters[1..], current_value + parameters[0]) ||
    has_equation_solution(test_value, parameters[1..], current_value * parameters[0])
end

equations = load_input('input')
sum = 0

equations.each do |equation|
  test_value = equation[0]
  parameters = equation[1]
  if has_equation_solution(test_value, parameters[1..], parameters[0])
    sum += test_value
  end
end

# should output 2299996598890
puts sum
