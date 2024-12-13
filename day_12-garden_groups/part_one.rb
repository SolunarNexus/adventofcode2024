#!/usr/bin/ruby

def load_input(filename = 'input')
  garden = []

  File.readlines(filename, chomp: true).each_with_index do |line, line_index|
    garden.append line
  end
  garden
end

def is_outside_of_bounds(x, y, garden)
  y < 0 || y >= garden.length || x < 0 || x >= garden[0].length
end

def belongs_to_region(plant, x, y, garden)
  if is_outside_of_bounds(x, y, garden)
    return false
  end
  garden[y][x] == plant
end

def update_region_properties(plant, x, y, garden, region_properties, visited)
  if is_outside_of_bounds(x, y, garden) || visited[y][x] || garden[y][x] != plant
    return
  end

  visited[y][x] = true
  plant_perimeter = [[x + 1, y], [x, y + 1], [x - 1, y], [x, y - 1]]
                      .map { |x2, y2| belongs_to_region(plant, x2, y2, garden) }
                      .map { |belongs| belongs ? 0 : 1 }
                      .sum
  region_properties[0] += 1
  region_properties[1] += plant_perimeter

  update_region_properties(plant, x + 1, y, garden, region_properties, visited)
  update_region_properties(plant, x, y + 1, garden, region_properties, visited)
  update_region_properties(plant, x - 1, y, garden, region_properties, visited)
  update_region_properties(plant, x, y - 1, garden, region_properties, visited)
end

def compute_price_per_region(garden_regions)
  price_per_region = Hash.new

  garden_regions.each do |plant, regions|
    regions.each do |area, perimeter|
      price_per_region[plant] = price_per_region.fetch(plant, 0) + area * perimeter
    end
  end
  price_per_region
end

def compute_regions_properties(garden, garden_regions)
  visited_plants = Array.new(garden.length) { Array.new(garden[0].length) { false } }

  garden.each_with_index do |line, y|
    line.each_char.with_index do |plant, x|
      if visited_plants[y][x]
        next
      end
      if garden_regions.has_key? plant
        garden_regions[plant].append Array.new [0, 0]
      else
        garden_regions[plant] = [Array.new([0, 0])]
      end

      update_region_properties(plant, x, y, garden, garden_regions[plant].last, visited_plants)
    end
  end
end

garden = load_input('input')
garden_regions = Hash.new

compute_regions_properties(garden, garden_regions)
prices = compute_price_per_region(garden_regions)

# should output 1375574
# puts "Total price: #{prices.values.sum}"