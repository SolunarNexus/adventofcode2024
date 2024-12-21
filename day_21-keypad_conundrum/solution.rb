require 'matrix'
codes = []

File.readlines("input", chomp: true).each do |line|
  codes << line
end

$positions = {
  '7' => Vector[0, 0],
  '8' => Vector[0, 1],
  '9' => Vector[0, 2],
  '4' => Vector[1, 0],
  '5' => Vector[1, 1],
  '6' => Vector[1, 2],
  '1' => Vector[2, 0],
  '2' => Vector[2, 1],
  '3' => Vector[2, 2],
  '0' => Vector[3, 1],
  'A' => Vector[3, 2],
  '^' => Vector[0, 1],
  'a' => Vector[0, 2],
  '<' => Vector[1, 0],
  'v' => Vector[1, 1],
  '>' => Vector[1, 2]
}
$directions = {
  '^' => Vector[-1, 0],
  'v' => Vector[1, 0],
  '<' => Vector[0, -1],
  '>' => Vector[0, 1]
}

def se_to_moveset(start, fin, avoid = Vector[0, 0])
  delta = fin - start
  string = ''
  dx = delta[0]
  dy = delta[1]
  if dx < 0
    string += '^' * dx.abs
  else
    string += 'v' * dx
  end
  if dy < 0
    string += '<' * dy.abs
  else
    string += '>' * dy
  end
  rv = string.chars.permutation.to_a.uniq
             .filter { |s|
               !s.map { $directions[_1] }
                 .reduce([start]) { _1 + [_1.last + _2] }
                  .any? { _1 == avoid }
             }.map { _1.join + 'a' }
  rv = ['a'] if rv == []
  rv
end

$ml_memos = {}

def min_length(str, lim = 2, depth = 0)
  memo_key = [str, depth, lim]
  return $ml_memos[memo_key] if $ml_memos[memo_key]
  avoid = depth == 0 ? Vector[3, 0] : Vector[0, 0]
  # Cursor was just on A
  cur = depth == 0 ? $positions['A'] : $positions['a']
  length = 0
  str.chars.each do |char|
    next_cur = $positions[char]
    moveset = se_to_moveset(cur, next_cur, avoid)
    if depth == lim
      length += (moveset[0] || 'a').size
    else
      length += moveset.map { min_length(_1, lim, depth + 1) }.min
    end
    cur = next_cur
  end
  $ml_memos[memo_key] = length
  length
end

complexity_a = 0
complexity_b = 0
codes.each do |code|
  length_a = min_length(code)
  length_b = min_length(code, 25)
  numeric = code[0..2].to_i
  complexity_a += length_a * numeric
  complexity_b += length_b * numeric
end

# should output 184180
puts "Part 1: #{complexity_a}"
# should output 231309103124520
puts "Part 2: #{complexity_b}"