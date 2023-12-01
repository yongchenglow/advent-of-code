require 'json'

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

data_cleaned = []

index_sum = 0

def compute_is_right_order(left_digit_arr, right_digit_arr)
  max_length = [left_digit_arr.length, right_digit_arr.length].max

  max_length.times do |round|
    if left_digit_arr[round].is_a?(Array) && right_digit_arr[round].is_a?(Array)
      temp = compute_is_right_order(left_digit_arr[round], right_digit_arr[round])
      return temp if [true, false].include? temp

      next
    end

    if left_digit_arr[round].is_a?(Array) && !right_digit_arr[round].is_a?(Array) && !right_digit_arr[round].nil?
      temp = compute_is_right_order(left_digit_arr[round], [right_digit_arr[round]])
      return temp if [true, false].include? temp

      next
    end

    if !left_digit_arr[round].is_a?(Array) && right_digit_arr[round].is_a?(Array) && !left_digit_arr[round].nil?
      temp = compute_is_right_order([left_digit_arr[round]], right_digit_arr[round])
      return temp if [true, false].include? temp

      next
    end

    return false if left_digit_arr[round] && right_digit_arr[round].nil?

    if left_digit_arr[round].nil? && right_digit_arr[round] || left_digit_arr[round] < right_digit_arr[round]
      return true
    end

    next if left_digit_arr[round] == right_digit_arr[round]

    return false
  end
end

# Form the matrix of trees
file_data.each_slice(3).each do |inputs|
  left_string, right_string = inputs
  left_digit_arr = JSON.parse(left_string)
  right_digit_arr = JSON.parse(right_string)
  data_cleaned << left_digit_arr
  data_cleaned << right_digit_arr
end

data_cleaned << [[2]]
data_cleaned << [[6]]

data_cleaned.sort! do |x, y|
  if compute_is_right_order(x, y)
    -1
  elsif x == y
    0
  else
    1
  end
end

puts (data_cleaned.find_index([[2]]) + 1) * (data_cleaned.find_index([[6]]) + 1)

file.close
