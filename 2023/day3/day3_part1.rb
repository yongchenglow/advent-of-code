# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the ids
part_numbers = []

# Method to check if string is numeric
def numeric?(string)
  /\A\d+\z/.match?(string)
end

# Method to check if a symbol is adjacent
def check_if_symbol_is_adjacent(data, row_index, column_index)
  return false if data[row_index][column_index] == '.' || !numeric?(data[row_index][column_index])

  # Above
  # .X.
  # .1.
  # ...
  if row_index.positive? && data[row_index - 1][column_index] != '.' && !numeric?(data[row_index - 1][column_index])
    return true
  end

  # Above left
  # X..
  # .1.
  # ...
  if row_index.positive? && column_index.positive? && data[row_index - 1][column_index - 1] != '.' && !numeric?(data[row_index - 1][column_index - 1])
    return true
  end

  # Above right
  # ..X
  # .1.
  # ...
  if row_index.positive? && column_index < data[row_index - 1].length - 1 && data[row_index - 1][column_index + 1] != '.' && !numeric?(data[row_index - 1][column_index + 1])
    return true
  end

  # Left
  # ...
  # X1.
  # ...
  if column_index.positive? && data[row_index][column_index - 1] != '.' && !numeric?(data[row_index][column_index - 1])
    return true
  end

  # Right
  # ...
  # .1X
  # ...
  if column_index < data[row_index].length - 1 && data[row_index][column_index + 1] != '.' && !numeric?(data[row_index][column_index + 1])
    return true
  end

  # Below
  # ...
  # .1.
  # .X.
  if row_index < data.length - 1 && data[row_index + 1][column_index] != '.' && !numeric?(data[row_index + 1][column_index])
    return true
  end

  # Below left
  # ...
  # .1.
  # X..
  if row_index < data.length - 1 && column_index.positive? && data[row_index + 1][column_index - 1] != '.' && !numeric?(data[row_index + 1][column_index - 1])
    return true
  end

  # Below right
  # ...
  # .1.
  # ..X
  if row_index < data.length - 1 && column_index < data[row_index + 1].length - 1 && data[row_index + 1][column_index + 1] != '.' && !numeric?(data[row_index + 1][column_index + 1])
    return true
  end

  false
end

file_data.each_with_index do |line_string, row_index|
  number = ''
  is_symbol_adjacent = false

  # Convert string to char array
  line_string.chars.each_with_index do |character, column_index|
    # Consolidate the numbers
    number += character if numeric?(character)

    # Only execute if is_symbol_adjacent is false
    is_symbol_adjacent ||= check_if_symbol_is_adjacent(file_data, row_index, column_index)

    # (Not a numer OR end of line) and Symbol is adjacent
    if (!numeric?(character) || column_index == line_string.length - 1) && is_symbol_adjacent
      # Add to the part numbers
      part_numbers << number.to_i
      is_symbol_adjacent = false
    end

    # Reset numbers
    number = '' unless numeric?(character)
  end
end

# Sum up all the numbers to get the answer
answer = part_numbers.sum

puts answer

file.close
