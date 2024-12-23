#!/usr/bin/ruby

def load_input(filename)
  File.readlines(filename, chomp: true).map(& :to_i)
end

def mix(number, constant)
  number ^ constant
end

def prune(number)
  number % 16777216
end

def next_secret(number)
  number = prune(mix(number, number << 6))
  number = prune(mix(number, number >> 5))
  number = prune(mix(number, number << 11))

  prune(number)
end

def compute_nth_secret(number, n=2000)
  n.times do
    number = next_secret(number)
  end
  number
end

initial_secrets = load_input("input")
sum = 0

initial_secrets.each do |secret|
  sum += compute_nth_secret(secret)
end

# should output 15006633487
puts sum