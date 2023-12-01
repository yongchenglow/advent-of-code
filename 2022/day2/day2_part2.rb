file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

CHOICE_NAME = {
  rock: 'rock',
  paper: 'paper',
  sissors: 'sissors'
}.freeze

RESULT_NAME = {
  win: 'win',
  draw: 'draw',
  lose: 'lose'
}.freeze

CHOICE_MAP = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'sissors',
  'X' => 'lose',
  'Y' => 'draw',
  'Z' => 'win'
}.freeze

CHOICE_SCORE = {
  'rock' => 1,
  'paper' => 2,
  'sissors' => 3
}.freeze

def win_choice(opponent_choice)
  case opponent_choice
  when CHOICE_NAME[:rock]
    CHOICE_NAME[:paper]
  when CHOICE_NAME[:paper]
    CHOICE_NAME[:sissors]
  when CHOICE_NAME[:sissors]
    CHOICE_NAME[:rock]
  end
end

def lose_choice(opponent_choice)
  case opponent_choice
  when CHOICE_NAME[:rock]
    CHOICE_NAME[:sissors]
  when CHOICE_NAME[:paper]
    CHOICE_NAME[:rock]
  when CHOICE_NAME[:sissors]
    CHOICE_NAME[:paper]
  end
end

total_score = 0

file_data.each do |game_string|
  opponent_value, game_result_value = game_string.split
  opponent_choice = CHOICE_MAP[opponent_value]
  game_result = CHOICE_MAP[game_result_value]

  # We Assume all input is value, therefore these two values exist
  if game_result == RESULT_NAME[:draw]
    # Tie game
    total_score += 3 + CHOICE_SCORE[opponent_choice]
  elsif game_result == RESULT_NAME[:win]
    # Win
    total_score += 6 + CHOICE_SCORE[win_choice(opponent_choice)]
  else
    # Lose
    total_score += CHOICE_SCORE[lose_choice(opponent_choice)]
  end
end

puts total_score

file.close
