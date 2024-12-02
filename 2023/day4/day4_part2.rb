# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

# Declare an empty hash to store the number of cards
cards = {}

file_data.each do |line_string|
  # Split the data by ':' or '|'
  card_string, winning_number_string, my_number_string = line_string.split(/[:|]/)
  _word, card_number = card_string.split
  winning_numbers = winning_number_string.split
  my_numbers = my_number_string.split

  # Find the same numbers between 2 arrays
  difference = winning_numbers & my_numbers

  # Increase the current card count by 1
  cards[card_number] = cards[card_number].nil? ? 1 : cards[card_number] + 1

  # Increase the number of bonus cards obtained
  ((card_number.to_i + 1)..(card_number.to_i + difference.length)).each do |number|
    # If nothing, initial should be the current number of cards
    # Else we add the current number of cards to the current value
    # Repeat until we reach the end of the list
    cards[number.to_s] = cards[number.to_s].nil? ? cards[card_number] : cards[number.to_s] + cards[card_number] if number <= file_data.length
  end
end

# Sum up all the numbers to get the answer
answer = cards.values.sum

puts answer

file.close
