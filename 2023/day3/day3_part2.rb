# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the ids
gear_ratios = []
ratios = []

# Method to check if string is numeric
def numeric?(string)
  /\A\d+\z/.match?(string)
end

# Method to remove dots from the numbers
def clean_number(string)
  number = string.match(/\d+/)
  number ? number[0] : nil
end

# Method to find the numbers for a particular row above and below is the same
def find_numbers_for_row(data, row_index, column_index)
  numbers = []

  # XXX....
  # ...*...
  # .......
  start_column_index1 = (column_index - 3).negative? ? 0 : column_index - 3
  end_column_index1 = (column_index - 1).negative? ? 0 : column_index - 1

  # .XXX...
  # ...*...
  # .......
  start_column_index2 = (column_index - 2).negative? ? 0 : column_index - 2
  end_column_index2 = column_index

  # ..XXX..
  # ...*...
  # .......
  start_column_index3 = (column_index - 1).negative? ? 0 : column_index - 1
  end_column_index3 = column_index + 1 < data[row_index].length - 1 ? column_index + 1 : data[row_index].length - 1

  # ...XXX.
  # ...*...
  # .......
  start_column_index4 = column_index
  end_column_index4 = column_index + 2 < data[row_index].length - 1 ? column_index + 2 : data[row_index].length - 1

  # ....XXX
  # ...*...
  # .......
  start_column_index5 = column_index + 1 < data[row_index].length - 1 ? column_index + 1 : data[row_index].length - 1
  end_column_index5 = column_index + 3 < data[row_index].length - 1 ? column_index + 3 : data[row_index].length - 1

  # If all 3 are numbers we take it
  # ..XXX..
  # ...*...
  # .......
  number3 = clean_number(data[row_index][start_column_index3..end_column_index3])
  if number3 && number3.length == 3
    numbers << number3.to_i
  else
    number1 = clean_number(data[row_index][start_column_index1..end_column_index1])
    number2 = clean_number(data[row_index][start_column_index2..end_column_index2])
    number4 = clean_number(data[row_index][start_column_index4..end_column_index4])
    number5 = clean_number(data[row_index][start_column_index5..end_column_index5])

    # Check the center number to see if it is numeric
    # ...X...
    # ...*...
    # .......
    if numeric?(data[row_index][column_index])
      # Take the left number if left number is greater than the right number
      if number2 && (number2.length >= number4.length || !number4)
        # .XXX...
        # ...*...
        # .......
        numbers << number2.to_i
      elsif number4
        # ...XXX.
        # ...*...
        # .......
        numbers << number4.to_i
      end
    else
      # Check the left number to see if it is numeric
      # ..X....
      # ...*...
      # .......
      if numeric?(data[row_index][start_column_index3])
        if number1 && (number1.length >= number2.length || !number2)
          # XXX....
          # ...*...
          # .......
          numbers << number1.to_i
        elsif number2
          # .XXX...
          # ...*...
          # .......
          numbers << number2.to_i
        end
      end
      # Check the left number to see if it is numeric
      # ....X..
      # ...*...
      # .......
      if numeric?(data[row_index][end_column_index3])
        if number4 && (number4.length >= number5.length || !number5)
          # ...XXX.
          # ...*...
          # .......
          numbers << number4.to_i
        elsif number5
          # ....XXX
          # ...*...
          # .......
          numbers << number5.to_i
        end
      end
    end
  end

  numbers
end

# Assumptions, numbers must be in 3's
def find_gear_ratios(data, row_index, column_index)
  numbers = []

  # Above
  # XXX
  # .*.
  # ...
  numbers += find_numbers_for_row(data, row_index - 1, column_index) if row_index.positive?

  # Below
  # ...
  # .*.
  # XXX
  numbers += find_numbers_for_row(data, row_index + 1, column_index) if row_index < data.length - 1

  # Left
  # .....
  # XXX*.
  # .....
  if column_index > 2
    # /\d+$/ end with numbers
    number = (data[row_index][(column_index - 3)..(column_index - 1)]).scan(/\d+$/)[0]
    numbers << number.to_i if number
  end

  # Right
  # .....
  # .*XXX
  # .....
  if column_index < data[row_index].length - 3
    # /^\d+/ start with numbers
    number = (data[row_index][(column_index + 1)..(column_index + 3)]).scan(/^\d+/)[0]
    numbers << number.to_i if number
  end

  # I want to send is_gear followed by the first and second number
  # [is_gear, first_number, second_number]
  numbers.unshift(numbers.length == 2)
end

file_data.each_with_index do |line_string, row_index|
  line_string.chars.each_with_index do |character, column_index|
    next if character != '*'

    is_gear, first_number, second_number = find_gear_ratios(file_data, row_index, column_index)
    ratios << [first_number, second_number] if is_gear
    gear_ratios << first_number * second_number if is_gear
  end
end

# Sum up all the numbers to get the answer
answer = gear_ratios.sum

p ratios

# 87605697
puts answer

file.close
