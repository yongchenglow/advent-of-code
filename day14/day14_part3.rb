file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

START_POINT = [50, 0].freeze
OFFSET = 450
WIDTH = 200
HEIGHT = 100
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
  (row..limit).each do |index|
          # p [col, row]
    return sand_units if index == limit

    next if cave[index + 1][col].nil?
    # p [col, row]
    # puts index
    # case cave[index + 1][col]
    # when BLOCK
    #   if cave[index + 1][col - 1].nil?
    #     return drop_sand(cave, limit, col - 1, index + 1, sand_units)
    #   elsif cave[index + 1][col + 1].nil?
    #     return drop_sand(cave, limit, col + 1, index + 1, sand_units)
    #   else
    #     cave[index][col] = SAND
    #     return drop_sand(cave, limit, START_POINT[0], START_POINT[1], sand_units + 1)
    #   end
    # when SAND
      if cave[index + 1][col - 1].nil?
        # puts "left"
        # return drop_sand(cave, limit,col - 1,index + 1, sand_units)
        left_row = index + 1
        left_col = col - 1
        added = 0
        (limit - left_row).times do |i|
          if cave[left_row + i + 1][left_col - i - 1].nil? && !cave[left_row + i + 2][left_col - i - 1].nil? && left_row + i + 2 < limit
            cave[left_row + i + 1][left_col - i - 1] = SAND
            added += 1
          elsif cave[left_row + i + 2][left_col - i - 1].nil? && left_row + i + 2 < limit && cave[left_row + i + 1][left_col - i - 1].nil?
            return drop_sand(cave, limit,left_col - i - 1,left_row + i + 1, sand_units + added)
          end
          # if cave[left_row + i + 2][left_col - i - 1].nil? && left_row + i + 2 < limit && cave[left_row + i + 1][left_col - i - 1].nil?
          #   return drop_sand(cave, limit,left_col - i - 1,left_row + i + 1, sand_units)
          # elsif !cave[left_row + i + 1][left_col - i - 1].nil?
          #   cave[left_row + i][left_col - i] = SAND
          #   return drop_sand(cave, limit, START_POINT[0], START_POINT[1], sand_units + 1)
          # end
        end
        return drop_sand(cave, limit,START_POINT[0], START_POINT[1], sand_units + added)
      elsif cave[index + 1][col + 1].nil?
        # puts "right"
        # return drop_sand(cave, limit,col+1,index + 1, sand_units)
        right_row = index + 1
        right_col = col + 1
        added = 0
        (limit - right_row).times do |i|
          if cave[right_row + i + 1][right_col + i + 1].nil? && !cave[right_row + i + 2][right_col + i + 1].nil? && right_row + i + 2 < limit
            cave[left_row + i + 1][left_col - i - 1] = SAND
            added += 1
          elsif cave[right_row + i + 2][right_col + i + 1].nil? && right_row + i + 2 < limit && cave[right_row + i + 1][right_col + i + 1].nil?
            return drop_sand(cave, limit,right_col + i + 1,right_row + i + 1, sand_units + added)
          # elsif !cave[right_row + i + 1][right_col + i + 1].nil?
          #   cave[right_row + i][right_col + i] = SAND
          #   return drop_sand(cave, limit, START_POINT[0], START_POINT[1], sand_units + 1)
          end
        end
        return drop_sand(cave, limit,START_POINT[0], START_POINT[1], sand_units + added)
      else
        # puts "sand"
        cave[index][col] = SAND
        return drop_sand(cave, limit, START_POINT[0], START_POINT[1], sand_units + 1)
      end
    # end
  end
end


puts drop_sand(cave, max_height, START_POINT[0], START_POINT[1], 0)

# pp cave

# p max_height

file.close
