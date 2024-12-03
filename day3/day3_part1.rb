# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare safe
sum = 0

file_data.each do |line_string|
  matches = line_string.scan(/mul\((\d+),(\d+)\)/)
  matches.each do |first_number, second_number|
    sum += first_number.to_i * second_number.to_i
  end
end

puts sum

file.close
