# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

def find_histories(values)
  current_values = values.last

  # Guard clause, we stop if all values in the array are 0
  return values if current_values.all?(0)

  difference = []
  current_values.each_with_index do |value, index|
    # We stop because there isn't any more values
    break if index == current_values.length - 1

    difference << current_values[index + 1] - value
  end

  # Append the difference array to the values array
  values << difference

  # Call again
  find_histories(values)
end

# Declare an empty number array to store the points
histories = []

file_data.each do |line_string|
  values = line_string.split.map(&:to_i)
  histories << find_histories([values]).map(&:last).sum
end

# Sum up all the numbers to get the answer
answer = histories.sum

puts answer

file.close
