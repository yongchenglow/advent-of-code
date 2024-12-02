# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare safe
safe_lines = 0

def is_safe(numbers)
  previous_number = numbers[0]
  diff = numbers[1] - numbers[0]
  numbers[1..-1].all? do |current_number|
    current_difference = current_number - previous_number
    is_always_increasing_or_decreasing = (diff < 0 && current_difference < 0) || (diff > 0 && current_difference > 0)
    is_diff_between_zero_and_four = current_difference.abs < 4 && current_difference.abs > 0
    previous_number = current_number

    is_always_increasing_or_decreasing && is_diff_between_zero_and_four
  end
end

file_data.each do |line_string|
  numbers = line_string.split.map(&:to_i)
  safe_lines += 1 if is_safe(numbers)
end

puts safe_lines

file.close
