# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the numbers
numbers = []

file_data.each do |line_string|
  # Replace all non 1 to 9 with empty string then split the string into chars
  number_string = line_string.gsub(/[^\d]/, '').split('')
  # Combine the first and last string and generate the 2 digit number
  numbers << (number_string.first + number_string.last).to_i
end

# Sum up all the numbers to get the answer
answer = numbers.sum

puts answer

file.close
