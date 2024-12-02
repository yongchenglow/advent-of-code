# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

steps = 0
network = {}

moves = file_data[0]

current_value = ''

file_data.drop(2).each_with_index do |line_string, index|
  key, values = line_string.split('=')
  current_value = key.strip if index.zero?
  network[key.strip] = values.gsub(/[() ]/, '').split(',')
end

loop do
  moves.chars.each do |move|
    case move
    when 'L'
      current_value = network[current_value][0]
    when 'R'
      current_value = network[current_value][1]
    end

    p current_value
    steps += 1
    break if current_value == 'ZZZ'
  end
  break if current_value == 'ZZZ'
end

puts steps

file.close
