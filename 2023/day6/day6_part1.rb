# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

times = file_data[0].split.drop(1).map(&:to_i)
winning_distances = file_data[1].split.drop(1).map(&:to_i)

winning_ways = []

times.each_with_index do |time, index|
  winning_distance = winning_distances[index]
  wins = 0
  time.times do |i|
    wins += 1 if i * (time - i) > winning_distance
  end
  winning_ways << wins
end

# Sum up all the numbers to get the answer
answer = winning_ways.reduce(:*)

puts answer

file.close
