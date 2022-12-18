file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

fully_contain_count = 0

file_data.each do |pairs_string|
  pairs = pairs_string.split(',')

  pair1_first_num, pair1_second_num = pairs[0].split('-')
  pair2_first_num, pair2_second_num = pairs[1].split('-')

  # 0..2 means 0, 1, 2
  # 0...2 means 0, 1
  first_array_num = Array(pair1_first_num..pair1_second_num)
  second_array_num = Array(pair2_first_num..pair2_second_num)

  # Returns an array of the overlap pairs
  common_numbers = first_array_num & second_array_num

  is_fully_contain = common_numbers.length == first_array_num.length || common_numbers.length == second_array_num.length
  fully_contain_count += 1 if is_fully_contain
end

puts fully_contain_count

file.close
