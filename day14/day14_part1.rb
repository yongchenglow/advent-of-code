file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

START_POINT = [500, 0].freeze
OFFSET = 0
WIDTH = 200
HEIGHT = 1000
cave = Array.new(WIDTH) { Array.new(HEIGHT) }

# WIDTH.times do |x|
#   HEIGHT.times do |y|

#     cave[x][y] = 0
#     cave[x][y] = 2 if x == 0 && y == 50
#   end
# end

max_height = 0

BLOCK = "#"
SAND = "+"

def draw_line(start_col, start_row, end_col, end_row, matrix)

  if start_col == end_col
    ((start_row - end_row).abs + 1).times do |index|
      if start_row > end_row
        matrix[start_row - index][start_col - OFFSET] = BLOCK
      else
        matrix[start_row + index][start_col - OFFSET] = BLOCK
      end
    end
  else
    ((start_col - end_col).abs + 1).times do |index|
      if start_col > end_col
        matrix[start_row][start_col - index - OFFSET] = BLOCK
      else
        matrix[start_row][start_col + index - OFFSET] = BLOCK
      end
    end
  end
end

# Form the matrix
file_data.each do |data_string|
  data = data_string.split('->')
  data.each_with_index do |point, index|
    next if index == data.length - 1

    start_col, start_row = point.split(',').map { |item| item.strip.to_i }
    end_col, end_row = data[index + 1].split(',').map { |item| item.strip.to_i }
    max_height = start_row if start_row > max_height

    draw_line(start_col, start_row, end_col, end_row, cave)
  end
end

def drop_sand(cave, limit, col, row, sand_units)
  return sand_units if row == limit

  return drop_sand(cave, limit, col, row + 1, sand_units) if cave[row + 1][col].nil?
  if cave[row + 1][col - 1].nil?
    return drop_sand(cave, limit, col - 1, row + 1, sand_units)
  elsif cave[row + 1][col + 1].nil?
    return drop_sand(cave, limit, col + 1, row + 1, sand_units)
  else
    cave[row][col] = SAND
    return drop_sand(cave, limit, START_POINT[0], START_POINT[1], sand_units + 1)
  end
end


puts drop_sand(cave, max_height, START_POINT[0], START_POINT[1], 0)

# pp cave

# p max_height

file.close
