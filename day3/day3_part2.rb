# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare safe
sum = 0

all_string = ""

# Join all the strings
file_data.each do |line_string|
  all_string += line_string
end

do_multiplications = all_string.split("do()")

do_multiplications.each do |do_line|
  # Remove all the don'ts
  cleaned_do_line = do_line.sub(/don't\(\).*/, '')

  # Multiply
  matches = cleaned_do_line.scan(/mul\((\d+),(\d+)\)/)
  matches.each do |first_number, second_number|
    sum += first_number.to_i * second_number.to_i
  end
end

puts sum

file.close
