# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.each_line.map { |line| line.chomp.chars }

sum = 0

def count_mas(line)
  line.scan(/MAS|SAM/).length
end


def check_if_mas(data,row,col)
  line1 = data[row-1][col-1] + 'A' + data[row+1][col+1]
  line2 = data[row-1][col+1] + 'A' + data[row+1][col-1]
  count_mas(line1) > 0 && count_mas(line2) > 0
end

file_data[1..-2].each_with_index do |row, row_index|
  row[1..-2].each_with_index do |char, col_index|
    if char == 'A'
      sum += 1 if check_if_mas(file_data,row_index+1,col_index+1)
    end
  end
end

puts sum

file.close
