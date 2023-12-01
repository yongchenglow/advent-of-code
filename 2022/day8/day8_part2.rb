file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

data_length = file_data.length
data = Array.new(data_length) { Array.new(data_length) }

# Form the matrix of trees
file_data.each_with_index do |input, row_index|
  input_row = input.each_char.map(&:to_i)
  input_row.each_with_index do |tree, col_index|
    data[row_index][col_index] = tree
  end
end

# Method to compute the tree visibility given the range and information
def compute_current_tree_visibility(range, fixed_index, is_row_fixed, data, current_tree)
  visible_trees = 0

  range.each do |index|
    visible_trees += 1
    # Break depending on direction
    # If row is fixed, break when changing the column
    # If the row is not fixed, break when changing the row
    should_break = (is_row_fixed && current_tree <= data[fixed_index][index] ||
                    !is_row_fixed && current_tree <= data[index][fixed_index])
    break if should_break
  end
  return 1 if visible_trees.zero?

  visible_trees
end

scenic_score = 0

# Go through the matrix of trees
data.each_with_index do |row, row_index|
  # Since the outer rows have a 0, we can skip these
  next if row_index.zero? || row_index == data_length - 1

  row.each_with_index do |_tree, col_index|
    # Since the outer columns have a 0, we can skip these
    next if col_index.zero? || col_index == data_length - 1

    # Get the current tree
    current_tree = data[row_index][col_index]

    # Get visible trees
    left = compute_current_tree_visibility(((col_index + 1)...data_length).to_a, row_index, true, data, current_tree)
    right = compute_current_tree_visibility((0...col_index).to_a.reverse, row_index, true, data, current_tree)
    up = compute_current_tree_visibility(((row_index + 1)...data_length).to_a, col_index, false, data, current_tree)
    down = compute_current_tree_visibility((0...row_index).to_a.reverse, col_index, false, data, current_tree)

    # Obtain the scenic score
    scenic_score = left * right * up * down if left * right * up * down > scenic_score
  end
end

puts scenic_score

file.close
