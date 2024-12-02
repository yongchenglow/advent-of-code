# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the numbers
first_list = []
second_hash = {}

file_data.each do |line_string|
  # Split the list and convert them to string
  first_number, second_number = line_string.split.map(&:to_i)

  first_list << first_number

  second_hash[second_number] ||= 0 # init 0 if it does not exist
  second_hash[second_number] += 1
end

similarity = 0

first_list.each do |number|
  similarity += number * second_hash[number] if second_hash[number]
end

puts similarity

file.close
