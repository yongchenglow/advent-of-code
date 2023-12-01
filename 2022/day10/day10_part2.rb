file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

register_value = 1
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
  current_value = index % 40
  puts '' if current_value.zero?

  # p [register_value, current_value]

  if register_value + 1 == current_value || register_value == current_value || register_value - 1 == current_value
    print '#'
    # puts '#'
  else
    print '.'
    # puts '.'
  end

  register_value += value
  # break if index == 20
end

file.close
