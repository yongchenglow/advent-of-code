file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

DATA_HEIGHT = file_data.length
DATA_LENGTH = file_data.first.length
CHAR_MAP = Array.new(DATA_HEIGHT) { Array.new(DATA_LENGTH) }
HEIGHT_MAP = Array.new(DATA_HEIGHT) { Array.new(DATA_LENGTH) }
VISITED_MAP = Array.new(DATA_HEIGHT) { Array.new(DATA_LENGTH) }

elevation_map = {}
# Generate the score map
# Lowercase item types a through z have priorities 1 through 26.
('a'..'z').each_with_index do |letter, index|
  elevation_map[letter] = index + 1
end
elevation_map['S'] = 1
elevation_map['E'] = 26

start_position = []
end_position = []

# Form the matrix of trees
file_data.each_with_index do |input_row, row_index|
  chars = input_row.each_char
  chars.each_with_index do |char, col_index|
    start_position = [row_index, col_index] if char == 'S'
    end_position = [row_index, col_index] if char == 'E'
    HEIGHT_MAP[row_index][col_index] = elevation_map[char] || 0
    CHAR_MAP[row_index][col_index] = char
  end
end

def find_shortest_route(start_position, end_position)
  queue = []
  queue.push(start_position.push(0))
  VISITED_MAP[start_position[0]][start_position[1]] = true

  while queue.size != 0
    current_position = queue.shift
    row_index, col_index, distance = current_position

    distance = 0 if HEIGHT_MAP[row_index][col_index] == 1
    # VISITED_MAP[row_index][col_index] = true
    # p CHAR_MAP[row_index][col_index]
    # [row_index,col_index]
    return distance if [row_index, col_index] == end_position

    current_elevation = HEIGHT_MAP[row_index][col_index]

    if row_index + 1 < DATA_HEIGHT &&
       VISITED_MAP[row_index + 1][col_index].nil? &&
       current_elevation - HEIGHT_MAP[row_index + 1][col_index] > -2
      VISITED_MAP[row_index + 1][col_index] = true
      queue.push([row_index + 1, col_index, distance + 1])
    end

    if row_index - 1 >= 0 &&
       VISITED_MAP[row_index - 1][col_index].nil? &&
       current_elevation - HEIGHT_MAP[row_index - 1][col_index] > -2
      VISITED_MAP[row_index - 1][col_index] = true
      queue.push([row_index - 1, col_index, distance + 1])
    end

    if col_index + 1 < DATA_LENGTH &&
       VISITED_MAP[row_index][col_index + 1].nil? &&
       current_elevation - HEIGHT_MAP[row_index][col_index + 1] > -2
      VISITED_MAP[row_index][col_index + 1] = true
      queue.push([row_index, col_index + 1, distance + 1])
    end

    if col_index - 1 >= 0  &&
       VISITED_MAP[row_index][col_index - 1].nil? &&
       current_elevation - HEIGHT_MAP[row_index][col_index - 1] > -2
      VISITED_MAP[row_index][col_index - 1] = true
      queue.push([row_index, col_index - 1, distance + 1])
    end
  end
end

puts find_shortest_route(start_position, end_position)

file.close
