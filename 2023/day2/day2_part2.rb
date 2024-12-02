# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty number array to store the ids
game_powers = []

file_data.each do |line_string|
  fewest_cube = {
    'red' => 0,
    'green' => 0,
    'blue' => 0
  }
  _game, sets = line_string.split(':')
  sets.split(';').each do |set|
    cubes = set.split(',')
    cubes.each do |cube|
      number, color = cube.split
      fewest_cube[color] = number.to_i if number.to_i > fewest_cube[color]
    end
  end

  game_powers << fewest_cube['red'] * fewest_cube['green'] * fewest_cube['blue']
end

# Sum up all the numbers to get the answer
answer = game_powers.sum

puts answer

file.close
