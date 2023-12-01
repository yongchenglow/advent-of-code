require 'json'

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

index_sum = 0

def compute_is_right_order(left_digit_arr, right_digit_arr)
  # check 1: lower integer should come first
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

    # p "fn"
    # p round
    # p left_digit_arr[round]
    # p right_digit_arr[round]
    # puts left_digit_arr[round] < right_digit_arr[round]
    return false if left_digit_arr[round] && right_digit_arr[round].nil?


    if left_digit_arr[round].nil? && right_digit_arr[round] || left_digit_arr[round] < right_digit_arr[round]
      return true
    end

    next if left_digit_arr[round] == right_digit_arr[round]

    return false
  end
  # check 2: both values are list

  # check 3
end

# Form the matrix of trees
file_data.each_slice(3).each_with_index do |inputs, index|
  left_string, right_string = inputs
  left_digit_arr = JSON.parse(left_string)
  right_digit_arr = JSON.parse(right_string)
  is_right_order = compute_is_right_order(left_digit_arr, right_digit_arr)
  # p [left_digit_arr, right_digit_arr]
  # puts is_right_order
  index_sum += index + 1 if is_right_order
  # p "sum"
  # p index_sum
end

puts index_sum

file.close
