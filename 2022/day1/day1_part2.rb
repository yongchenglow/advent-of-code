file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

top3_calorie_count = []
current_calorie_count = 0

def check_calorie_count(top3, current)
  if top3.length < 3
    # Fill up the array with 3 numbers
    top3 << current
    top3.sort # Sort the array so we only compare the first value
  elsif current > top3[0]
    top3.shift # Remove the first item in the array
    top3.push(current) # Push the new number into the array
    top3.sort # Sort the array so we only need to compare with one number
  else
    top3 # Return the same array if no change
  end
end

file_data.each do |calorie_integer_string|
  if calorie_integer_string != '' # '' means next elf
    current_calorie_count += calorie_integer_string.to_i
  else
    # Check to see if the calories the elf is carrying is in the most 3
    top3_calorie_count = check_calorie_count(top3_calorie_count, current_calorie_count)
    current_calorie_count = 0
  end
end
# We need to do this again as the end of input is not '' but a string
top3_calorie_count = check_calorie_count(top3_calorie_count, current_calorie_count)

puts top3_calorie_count.sum

file.close
