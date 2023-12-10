# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the points
points = []

file_data.each do |line_string|
  # Split the data by ':' or '|'
  _card, winning_number_string, my_number_string = line_string.split(/[:|]/)
  winning_numbers = winning_number_string.split
  my_numbers = my_number_string.split

  # Find the same numbers between 2 arrays
  difference = winning_numbers & my_numbers

  # If a match occur calculate the points
  # Notice the formula is:
  # 1 match = 1 or 2^0
  # 2 match = 2 or 2^1
  # 3 match = 4 or 2^2
  # 4 match = 8 or 2^3
  points << 2**(difference.length - 1) if difference.length.positive?
end

# Sum up all the numbers to get the answer
answer = points.sum

puts answer

file.close
