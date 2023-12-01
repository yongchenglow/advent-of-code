file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

ROUNDS = 10000
monkeys = {}

file_data.each_slice(7).each do |monkey_data|
  monkey_number = monkey_data[0].split[1].gsub(':', '').to_i
  # p monkey_number.to_i
  starting_items = monkey_data[1].split(':')[1].split(',').map { |item| item.strip.to_i }
  # p starting_items
  operation = monkey_data[2].split(':')[1].split('=')[1].strip
  # p operation
  test_divisible_by = monkey_data[3].scan(/\d+/).join('').to_i
  # p test_divisible_by
  true_condition = monkey_data[4].scan(/\d+/).join('').to_i
  # p true_condition
  false_condition = monkey_data[5].scan(/\d+/).join('').to_i
  # p false_condition
  monkeys[monkey_number] = {
    items: starting_items,
    operation:,
    test: test_divisible_by,
    true_condition:,
    false_condition:,
    items_inspected: 0
  }
end

temp = []
monkeys.each do |monkey_num, monkey|
  temp.push(monkey[:test])
end
DIVISIOR = temp.inject(:*)

def execute_operation(worry_level, operation_string)
  value1, operation, value2 = operation_string.split

  value1 = worry_level if value1 == 'old'
  value2 = value2 == 'old' ? worry_level : value2.to_i

  case operation
  when '*'
    result = value1 * value2
  when '+'
    result = value1 + value2
  when '-'
    result = value1 - value2
  when '/'
    result = value1 / value2
  end
  result % DIVISIOR
end

ROUNDS.times do |_round|
  monkeys.length.times do |index|
    monkey = monkeys[index]
    monkey[:items].each do |item|
      result = execute_operation(item, monkey[:operation])
      if (result % monkey[:test]).zero?
        monkeys[monkey[:true_condition]][:items].push(result)
      else
        monkeys[monkey[:false_condition]][:items].push(result)
      end
      monkey[:items_inspected] += 1
    end
    monkey[:items] = []
  end
end

total_items_inspected = []
monkeys.each do |monkey_num, monkey|
  total_items_inspected.push(monkey[:items_inspected])
end
total_items_inspected.sort!.reverse!
puts total_items_inspected[0] * total_items_inspected[1]

file.close
