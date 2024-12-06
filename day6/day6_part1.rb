require 'set'

# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.each_line.map { |line| line.chomp.chars }

class Direction
  UP = "UP"
  DOWN = "DOWN"
  LEFT = "LEFT"
  RIGHT = "RIGHT"

  def self.all
    [UP, DOWN, LEFT, RIGHT]
  end

  def self.map
    {
      Direction::UP => [-1, 0, Direction::RIGHT],
      Direction::RIGHT => [0, 1, Direction::DOWN],
      Direction::DOWN => [1, 0, Direction::LEFT],
      Direction::LEFT => [0, -1, Direction::UP]
    }
  end
end

GUARD = "^"
OBSTACLE = "#"
guard_position_r = 0
guard_position_c = 0

file_data.each_with_index do |line, row_index|
  guard_index = line.index(GUARD)
  if guard_index
    guard_position_r = row_index
    guard_position_c = guard_index
    break
  end
end

def out_of_bounds?(map, row, col)
  row < 0 || col < 0 || row >= map.length || col >= map[0].length
end

def compute_steps(map, row, col, direction, set)
  dx, dy, next_direction = Direction.map[direction]
  new_row, new_col = row + dx, col + dy

  return set.size if out_of_bounds?(map, new_row, new_col)

  if map[new_row][new_col] == OBSTACLE
    compute_steps(map, row, col, next_direction, set)
  else
    set.add([new_row, new_col])
    compute_steps(map, new_row, new_col, direction, set)
  end
end

puts compute_steps(file_data, guard_position_r, guard_position_c, Direction::UP, Set.new([[guard_position_r, guard_position_c]]))

file.close
