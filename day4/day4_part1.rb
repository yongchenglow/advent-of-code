# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.each_line.map { |line| line.chomp.chars }

def count_xmas(line)
  line.scan(/(?=(XMAS|SAMX))/).length
end

def count_row_sum(data)
  data.inject(0) { |acc, line| acc + count_xmas(line.join) }
end

def count_xmas_diagonal(data, line = '', row = 0, col = 0, sum = 0, add_row, add_col)
  if row >= data.length || col >= data[0].length || row < 0 || col < 0
    return sum += count_xmas(line)
  end

  return count_xmas_diagonal(data, line + data[row][col], row + add_row, col + add_col, sum, add_row, add_col)
end

def count_start_row_diagonal(data)
  sum = 0
  data[0].each_with_index do |char, index|
    sum += count_xmas_diagonal(data, '', 0, index, 1, 1) + count_xmas_diagonal(data, '', 0, index, 1, -1)
  end
  sum
end

def count_end_row_diagonal(data)
  sum = 0
  data[data.length - 1][1..-2].each_with_index do |char, index|
    sum += count_xmas_diagonal(data, '', data.length - 1, index + 1, -1, 1) + count_xmas_diagonal(data, '', data.length - 1, index + 1, -1, -1)
  end
  sum
end

transposed_file_data = file_data.transpose

puts count_row_sum(file_data) + count_row_sum(transposed_file_data) + count_start_row_diagonal(file_data) + count_end_row_diagonal(file_data)

file.close
