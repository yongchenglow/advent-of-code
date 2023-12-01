file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

register_value = 1
signal_strength = []
cycles_to_calculate_signal_strength = [20, 60, 100, 140, 180, 220]
queue = []

file_data.each do |input_row|
  if input_row == 'noop'
    queue.push(0)
  else
    _command, value = input_row.split
    queue.push(0)
    queue.push(value.to_i)
  end
end

queue.each_with_index do |value, index|
  signal_strength.push((index + 1) * register_value) if cycles_to_calculate_signal_strength.include?(index+1)
  register_value += value
end

p signal_strength

puts signal_strength.sum

file.close
