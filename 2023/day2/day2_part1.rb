# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

possible_bag = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

# Declare an empty number array to store the ids
possible_game_ids = []

file_data.each do |line_string|
  is_possible = true
  game, sets = line_string.split(':')
  sets.split(';').each do |set|
    cubes = set.split(',')
    cubes.each do |cube|
      number, color = cube.split
      if number.to_i > possible_bag[color]
        is_possible = false
        break
      end
    end
    break if is_possible == false
  end

  if is_possible
    _word, game_number = game.split
    possible_game_ids << game_number.to_i
  end
end

# Sum up all the numbers to get the answer
answer = possible_game_ids.sum

puts answer

file.close
