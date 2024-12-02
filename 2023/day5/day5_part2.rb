# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Obtain the seeds
seeds = file_data[0].scan(/\d+/).map(&:to_i)
seed_ranges = seeds.each_slice(2)
                   .map { |start, length| start...(start + length) }
maps = []

def transform_seed_ranges(seed_ranges, maps)
  seed_ranges.map do |seed_range|
    initial_ranges = [seed_range]
    destination_ranges = []
    maps.each do |map|
      destination, source, length = map
      unmapped_ranges = initial_ranges
      unmapped_ranges.each do |unmapped_range|
        range_start = unmapped_range.first
        range_end = unmapped_range.last

        if range_start > source && range_end <= source + length
          destination_ranges << ((destination + (range_start - source))...(destination + (range_end - source)))
          initial_ranges = []
        end

        if range_start <= source && range_end <= source + length && range_end >= source
          destination_ranges << (destination...(destination + (range_end - source + 1)))
          initial_ranges << range_start...source
        end

        if range_start > source && range_end > source + length && range_start < source + length
          destination_ranges << ((destination + (range_start - source))...(destination + length))
          initial_ranges << ((source + length)...range_end)
        end
      end
    end
    puts "final"
    p destination_ranges + initial_ranges
    destination_ranges + initial_ranges
  end.flatten
end

file_data.drop(2).each do |line_string|
  # Ignore the following line
  next if line_string.end_with?('map:')

  # If transform the object
  if line_string.empty?
    seed_ranges = transform_seed_ranges(seed_ranges, maps)
    p seed_ranges
    # p seed_ranges
    maps = []
  end

  # Create the map
  maps << line_string.scan(/\d+/).map(&:to_i) unless line_string.empty?
end

p 'last'
seed_ranges = transform_seed_ranges(seed_ranges, maps).sort { |num1, num2| num1.first <=> num2.first }

answer = seed_ranges.first.first

# 63179500
puts answer

file.close
