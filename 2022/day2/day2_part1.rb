file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

CHOICE_NAME = {
  rock: 'rock',
  paper: 'paper',
  sissors: 'sissors'
}.freeze

CHOICE_MAP = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'sissors',
  'X' => 'rock',
  'Y' => 'paper',
  'Z' => 'sissors'
}.freeze

CHOICE_SCORE = {
  'rock' => 1,
  'paper' => 2,
  'sissors' => 3
}.freeze

total_score = 0

file_data.each do |game_string|
  opponent_value, my_value = game_string.split
  opponent_choice = CHOICE_MAP[opponent_value]
  my_choice = CHOICE_MAP[my_value]

  # We Assume all input is value, therefore these two values exist
  if my_choice == opponent_choice
    # Tie game
    total_score += 3 + CHOICE_SCORE[my_choice]
  elsif (my_choice == CHOICE_NAME[:rock] && opponent_choice == CHOICE_NAME[:sissors] ||
        my_choice == CHOICE_NAME[:paper] && opponent_choice == CHOICE_NAME[:rock] ||
        my_choice == CHOICE_NAME[:sissors] && opponent_choice == CHOICE_NAME[:paper])
    # Win
    total_score += 6 + CHOICE_SCORE[my_choice]
  else
    # Lose
    total_score += CHOICE_SCORE[my_choice]
  end
end

puts total_score

file.close
