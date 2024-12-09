#!/usr/bin/ruby

def parse_input_file(filename)
  loading_rules = true
  ordering_rules = Hash.new
  manuals_to_produce = []

  File.readlines(filename, chomp: true).each do |line|
    if line.length == 0
      loading_rules = false
      next
    end

    if loading_rules
      preceding, succeeding = line.split(/\|/)

      if ordering_rules.has_key? preceding
        ordering_rules[preceding].append(succeeding)
      else
        ordering_rules[preceding] = [succeeding]
      end
    else
      manuals_to_produce.append(line.split(/,/))
    end
  end

  [ordering_rules, manuals_to_produce]
end

def is_correct_update(pages, ordering_rules)
  pages.each_with_index do |page, index|
    pages[index + 1..-1].each do |next_page|
      unless ordering_rules.fetch(page, []).include?(next_page)
        return false
      end
    end
  end
  true
end

def reorder_pages_correctly(pages, ordering_rules)
  new_pages = pages

  pages.each do |page|
    ordering_rules.fetch(page, []).each do |successor|
      current_page_idx = pages.find_index(page)
      successor_idx = pages.find_index(successor)

      if !successor_idx.nil? && current_page_idx > successor_idx
        new_pages.delete(page)
        new_pages.insert(successor_idx, page)
      end
    end
  end
  new_pages
end

ordering_rules, manuals_to_produce = parse_input_file('input')
middle_pages_sum = 0

manuals_to_produce.each do |pages|
  unless is_correct_update(pages, ordering_rules)
    correctly_ordered_manual = reorder_pages_correctly(pages, ordering_rules)
    middle_pages_sum += Integer(correctly_ordered_manual[correctly_ordered_manual.length / 2])
  end
end

# should output 6370
puts "#{middle_pages_sum}"