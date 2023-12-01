file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

START_POINT = 0

visited_points = []
head_position = [START_POINT, START_POINT]
tail_position = [START_POINT, START_POINT]
visited_points.push(tail_position)

def head_is_around_tail(head_position, tail_position)
  head_row, head_col = head_position
  tail_row, tail_col = tail_position
  row_diff = (head_row - tail_row).abs
  col_diff = (head_col - tail_col).abs
  row_diff < 2 && col_diff < 2
end

def move_head(direction, head_position)
  head_row, head_col = head_position
  case direction
  when 'R'
    [head_row, head_col + 1]
  when 'L'
    [head_row, head_col - 1]
  when 'U'
    [head_row + 1, head_col]
  when 'D'
    [head_row - 1, head_col]
  end
end

def move_tail(head_position, tail_position)
  head_row, head_col = head_position
  tail_row, tail_col = tail_position
  row_diff = head_row - tail_row
  col_diff = head_col - tail_col
  row_diff = -1 if row_diff.negative?
  row_diff = 1 if row_diff.positive?
  col_diff = -1 if col_diff.negative?
  col_diff = 1 if col_diff.positive?
  [tail_row + row_diff, tail_col + col_diff]
end

file_data.each do |input_row|
  direction, moves = input_row.split
  moves.to_i.times do |_move|
    head_position = move_head(direction, head_position)

    unless head_is_around_tail(head_position, tail_position)
      tail_position = move_tail(head_position, tail_position)
      visited_points.push(tail_position)
    end
  end
end

puts visited_points.uniq.length

file.close
