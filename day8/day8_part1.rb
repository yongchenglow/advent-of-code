file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

data_length = file_data.length
data = Array.new(data_length) { Array.new(data_length) }
result = Array.new(data_length) { Array.new(data_length) }

# Warning: This is a brute force approach.
# I decided to do this to makes things easy to understand
# If you want to see a cleaner solution, please refer to part 2

# Form the matrix of trees
file_data.each_with_index do |input, row_index|
  input_row = input.each_char.map(&:to_i)
  input_row.each_with_index do |tree, col_index|
    data[row_index][col_index] = tree
  end
end

# Go through the matrix of trees
data.each_with_index do |row, row_index|
  current_tallest_tree_from_left = 0
  current_tallest_tree_from_right = 0
  current_tallest_tree_from_top = 0
  current_tallest_tree_from_bottom = 0

  # Trees to the left
  row.each_with_index do |tree, col_index|
    if row_index.zero? || row_index == data_length - 1
      result[row_index][col_index] = 1
    elsif col_index.zero? || col_index == data_length - 1
      result[row_index][col_index] = 1
      current_tallest_tree_from_left = tree
    elsif tree > current_tallest_tree_from_left
      result[row_index][col_index] = 1
      current_tallest_tree_from_left = tree
    end
  end

  # Trees to the right
  row.reverse.each_with_index do |tree, col_index|
    next if row_index.zero? || row_index == data_length - 1

    if col_index.zero? || col_index == data_length - 1
      current_tallest_tree_from_right = tree
    elsif tree > current_tallest_tree_from_right
      result[row_index][data_length - col_index - 1] = 1
      current_tallest_tree_from_right = tree
    end
  end

  data.each_with_index do |_col, col_index|
    top_tree = data[col_index][row_index]
    next if row_index.zero? || row_index == data_length - 1

    # Trees on top
    if col_index.zero? || col_index == data_length - 1
      current_tallest_tree_from_top = top_tree
    elsif top_tree > current_tallest_tree_from_top
      result[col_index][row_index] = 1
      current_tallest_tree_from_top = top_tree
    end

    # Trees on bottom
    bottom_tree = data[data_length - col_index - 1][row_index]
    if col_index.zero? || col_index == data_length - 1
      current_tallest_tree_from_bottom = bottom_tree
    elsif bottom_tree > current_tallest_tree_from_bottom
      result[data_length - col_index - 1][row_index] = 1
      current_tallest_tree_from_bottom = bottom_tree
    end
  end
end

visible_trees = 0

# Go through the result matrix, add up all the visible trees
result.each do |row|
  row.each do |value|
    visible_trees += 1 if value
  end
end

puts visible_trees

file.close
