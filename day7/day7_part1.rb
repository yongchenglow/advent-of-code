require 'set'

# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

sum = 0

def evaluate_numbers(target_value, numbers, current_sum = 0)
  if numbers.length == 0
    return target_value == current_sum
  end

  next_value = numbers[0]
  adjusted_numbers = numbers[1..-1]

  return evaluate_numbers(target_value, adjusted_numbers, current_sum + next_value) || evaluate_numbers(target_value, adjusted_numbers, current_sum * next_value)
end

file_data.each do |line|
  test_value_string, number_string = line.split(":")
  test_value = test_value_string.to_i
  numbers = number_string.split.map(&:to_i)
  start_value = numbers.shift
  sum += test_value if evaluate_numbers(test_value, numbers, start_value)
end

puts sum

file.close
