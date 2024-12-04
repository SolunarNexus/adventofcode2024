#!/usr/bin/ruby

lines = File.readlines('input', chomp: true)
safe_reports_count = lines.length

lines.each do |line|
  levels = line.split.map { |part| Integer(part) }
  prev_level = levels[0]
  increasing = prev_level < levels[1]

  levels[1..-1].each do |level|
    if (prev_level - level).abs < 1 || (prev_level - level).abs > 3 || (increasing && prev_level > level) || (!increasing && prev_level < level)
      safe_reports_count -= 1
      break
    end
    prev_level = level
  end
end

# should be 585
puts "#{safe_reports_count}"