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
NEW_OBSTACLE = "O"

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

  return 0 if out_of_bounds?(map, new_row, new_col)
  return 1 if set.include?([new_row, new_col, direction])

  if map[new_row][new_col] == OBSTACLE || map[new_row][new_col] == NEW_OBSTACLE
    compute_steps(map, row, col, next_direction, set)
  else
    set.add([new_row, new_col, direction])
    compute_steps(map, new_row, new_col, direction, set)
  end
end

def compute_loops(map, row, col, direction)
  loop_count = 0
  dx, dy, next_direction = Direction.map[direction]
  initial_row = row
  initial_col = col

  new_obstacle_position = Set.new()

  loop do
    new_row, new_col = row + dx, col + dy

    break if out_of_bounds?(map, new_row, new_col)

    if map[new_row][new_col] == OBSTACLE || map[new_row][new_col] == NEW_OBSTACLE
      direction = next_direction
      dx, dy, next_direction = Direction.map[direction]
    else
      row, col = new_row, new_col
      unless new_obstacle_position.include?([row, col])
        duplicated_map = map.map(&:dup)
        duplicated_map[row][col] = NEW_OBSTACLE
        new_obstacle_position.add([row, col])
        loop_count += compute_steps(duplicated_map, initial_row, initial_col, Direction::UP, Set.new([[initial_row, initial_col, Direction::UP]]))
      end
    end
  end

  loop_count
end

puts compute_loops(file_data, guard_position_r, guard_position_c, Direction::UP)

file.close
