#!/usr/bin/ruby

lines = File.readlines('input', chomp: true)
safe_reports_count = lines.length

# lines = ["1 3 2 4 5"]

def is_safe_without_one(levels, length)
  safe = nil

  levels.each_with_index do |_, index|
    safe = true
    reduced = levels.take(index).concat(levels.last(length - index - 1))
    prev_level = reduced[0]
    increasing = prev_level < reduced[1]

    reduced[1..-1].each do |level|
      if (prev_level - level).abs < 1 || (prev_level - level).abs > 3 || (increasing && prev_level > level) || (!increasing && prev_level < level)
        safe = false
        break
      end
      prev_level = level
    end

    if safe
      return true
    end
  end

  safe
end

lines.each do |line|
  levels = line.split.map { |part| Integer(part) }
  prev_level = levels[0]
  increasing = prev_level < levels[1]

  levels[1..-1].each_with_index do |level, index|
    if (prev_level - level).abs < 1 || (prev_level - level).abs > 3 || (increasing && prev_level > level) || (!increasing && prev_level < level)
      if !is_safe_without_one(levels, levels.length)
        safe_reports_count -= 1
      end
      break
    end
    prev_level = level
  end
end

# should be 626
puts "#{safe_reports_count}"