file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

UNIQUE_MESSAGE_LENGTH = 4

temp = []
marker = 0

# Split the string into characters
file_data[0].chars.each_with_index do |char, index|
  if index < UNIQUE_MESSAGE_LENGTH
    temp.push(char)
  elsif temp.uniq.length == temp.length # is unique
    marker = index
    break # stop if it is unique
  else
    temp.shift # remove the first
    temp.push(char) # add to the end
  end
end

puts marker

file.close
