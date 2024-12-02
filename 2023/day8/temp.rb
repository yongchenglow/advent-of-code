# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

def count_steps(node, instructions, network, &condition)
  (0...).each do |step|
    break step if condition.call(node)

    node = network[node][instructions[step % instructions.length]]
  end
end

steps = 0
network = {}

moves = file_data[0].chars.map { _1 == 'R' ? 1 : 0 }

current_value = ''

file_data.drop(2).each_with_index do |line_string, index|
  key, values = line_string.split('=')
  current_value = key.strip if index.zero?
  network[key.strip] = values.gsub(/[() ]/, '').split(',')
end


puts count_steps('AAA', moves, network) { _1 == 'ZZZ' }

puts network.keys.filter { _1.end_with?('A') }.map { |node|
      count_steps(node, moves, network) { _1.end_with?('Z') }
    }.reduce(&:lcm)
puts steps

file.close
