# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Obtain the seeds
seeds = file_data[0].scan(/\d+/).map(&:to_i)
maps = []

# Method to transform the seeds
def transform_seeds(seeds, maps)
  seeds.map do |seed|
    value = seed
    maps.each do |map|
      destination, source, length = map
      if value >= source && value < source + length
        value = destination + (value - source)
        break
      end
    end
    value
  end
end

file_data.drop(2).each do |line_string|
  # Ignore the line with 'map:'
  next if line_string.end_with?('map:')

  # If transform the object
  if line_string.empty?
    seeds = transform_seeds(seeds, maps)
    maps = []
  end

  # Create the map
  maps << line_string.scan(/\d+/).map(&:to_i) unless line_string.empty?
end

# Transform the seed when the data input ends
seeds = transform_seeds(seeds, maps)

answer = seeds.min

puts answer

file.close
