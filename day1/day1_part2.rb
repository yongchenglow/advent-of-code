# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the numbers
numbers = []

# Create a word to number map
word_to_string_number_map = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}

# Create an empty map
number_string_map = {}

# Generate the number string map
(1..9).each do |num|
  number_string_map[num.to_s] = num.to_s
end

# Combine the 2 maps
combined_map = word_to_string_number_map.merge(number_string_map)

# Tricky part is 'twone' is mean to turn into '21', hence a gsub will not work
file_data.each do |line_string|
  # We have to use the scan method for positive lookahead
  # We look for number words e.g. 'one' or digits and flatten them to receive an array of matches
  number_string = line_string.scan(/(?=(#{word_to_string_number_map.keys.join('|')}|\d))/).flatten

  # Map the matches to string and combine the first and last string and generate the 2 digit number
  numbers << (combined_map[number_string.first] + combined_map[number_string.last]).to_i
end

# Sum up all the numbers to get the answer
answer = numbers.sum

puts answer

file.close
