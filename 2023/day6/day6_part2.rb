# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

time = file_data[0].split.drop(1).join.to_i
winning_distance = file_data[1].split.drop(1).join.to_i

wins = 0
time.times do |i|
  wins += 1 if i * (time - i) > winning_distance
end

# Sum up all the numbers to get the answer
answer = wins

puts answer

file.close
