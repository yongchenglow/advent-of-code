file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

max_calorie_count = 0
current_calorie_count = 0

file_data.each do |calorie_integer_string|
  if calorie_integer_string != '' # '' means next elf
    # Compute how many calories the elf is carrying
    current_calorie_count += calorie_integer_string.to_i
  else
    # Check to see if the elf is carrying the most calories
    # If so store this value as the max_calorie_count
    max_calorie_count = current_calorie_count if current_calorie_count > max_calorie_count
    current_calorie_count = 0
  end
end
# We need to do this again as the end of input is not '' but a string
max_calorie_count = current_max if current_calorie_count > max_calorie_count

puts max_calorie_count

file.close
