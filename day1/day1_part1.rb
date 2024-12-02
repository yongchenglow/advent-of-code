# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the numbers
first_list = []
second_list = []

file_data.each do |line_string|
  # Split the list and convert them to string
  first_number, second_number = line_string.split.map(&:to_i)
  # Push the numbers into the respective list
  first_list << first_number
  second_list << second_number
end

# Sort the list and store the results
first_list.sort!
second_list.sort!

difference = 0

first_list.each_with_index do |number, index|
  difference += (number - second_list[index]).abs
end

puts difference

file.close
