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

# Elves are divided into groups of 3.
# In order to accomodate, we slice the dataset into groups of 3
# Put each group into an array
file_data.each_slice(3).to_a.each do |group|
  elve1_string, elve2_string, elve3_string = group

  # Find the common letters between the 3 elves
  # chars & chars & chars will return an array of common letters
  common_letters.push(elve1_string.chars & elve2_string.chars & elve3_string.chars)
end

# Common_letters is an array of arrays therefore we need to flatten it
common_letters.flatten.each do |common_letter|
  total_score += score_map[common_letter]
end

puts total_score

file.close
