#!/usr/bin/ruby

lines = File.readlines('input', chomp: true)
safe_reports_count = 0

def level_difference_too_high(level, prev_level)
  (prev_level - level).abs < 1 || (prev_level - level).abs > 3
end

def is_safe_report(levels)
  if levels.length < 2
    return true
  end

  prev_level = levels[0]
  increasing = prev_level < levels[1]

  levels[1..-1].each do |level|
    if level_difference_too_high(level, prev_level) || (increasing && prev_level > level) || (!increasing && prev_level < level)
      return false
    end
    prev_level = level
  end
  true
end

def is_safe_without_one(levels, length)
  levels.each_with_index do |_, index|
    reduced = levels.take(index).concat(levels.last(length - index - 1))

    if is_safe_report(reduced)
      return true
    end
  end

  false
end

lines.each do |line|
  levels = line.split.map { |part| Integer(part) }

  if is_safe_report(levels) || is_safe_without_one(levels, levels.length)
    safe_reports_count += 1
  end
end

# should be 626
puts "#{safe_reports_count}"