file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

common_letters = []
total_score = 0

score_map = {}
# Generate the score map
# Lowercase item types a through z have priorities 1 through 26.
('a'..'z').each_with_index do |letter, index|
  score_map[letter] = index + 1
end

# Uppercase item types A through Z have priorities 27 through 52.
('A'..'Z').each_with_index do |letter, index|
  score_map[letter] = index + 27
end

file_data.each do |compartments|
  # Split the input into the 2 compartments
  compartment1 = compartments[0, compartments.length / 2]
  compartment2 = compartments[compartments.length / 2, compartments.length]

  # Find the common letters between the 2 compartments
  # compartment1.chars & compartment2.chars will return an array of common letters
  common_letters.push(compartment1.chars & compartment2.chars)
end

# Common_letters is an array of arrays therefore we need to flatten it
common_letters.flatten.each do |common_letter|
  total_score += score_map[common_letter]
end

puts total_score

file.close
