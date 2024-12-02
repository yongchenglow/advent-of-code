# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

CARD_STRENGTH = {
  'A' => 13,
  'K' => 12,
  'Q' => 11,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2,
  'J' => 1
}

def hand_strength(hand)
  char_counts = Hash.new(0)
  strength = []
  hand.chars.each do |char|
    char_counts[char] += 1
    strength << CARD_STRENGTH[char]
  end
  five_of_a_kind = false
  four_of_a_kind = false
  three_of_a_kind = false
  pairs = 0
  j_count = char_counts.delete('J')

  char_counts.each_value do |count|
    case count
    when 5
      five_of_a_kind = true
    when 4
      four_of_a_kind = true
    when 3
      three_of_a_kind = true
    when 2
      pairs += 1
    end
  end

  case j_count
  when 5
    five_of_a_kind = true
  when 4
    five_of_a_kind = true
  when 3
    if pairs.positive?
      five_of_a_kind = true
    else
      four_of_a_kind = true
    end
  when 2
    if three_of_a_kind
      five_of_a_kind = true
    elsif pairs.positive?
      four_of_a_kind = true
    else
      three_of_a_kind = true
    end
  when 1
    if four_of_a_kind
      five_of_a_kind = true
    elsif three_of_a_kind
      four_of_a_kind = true
    elsif pairs == 2
      three_of_a_kind = true
    elsif pairs == 1
      three_of_a_kind = true
      pairs = 0
    else
      pairs += 1
    end
  end

  if five_of_a_kind
    [7, strength]
  elsif four_of_a_kind
    [6, strength]
  elsif three_of_a_kind && pairs.positive?
    [5, strength]
  elsif three_of_a_kind && pairs.zero?
    [4, strength]
  elsif pairs == 2
    [3, strength]
  elsif pairs == 1
    [2, strength]
  else
    [1, strength]
  end
end

hands = []

file_data.each do |line_string|
  hand, bet = line_string.split
  hand_score, hand_points = hand_strength(hand)
  hands << { hand_score:, hand_points:, bet: bet.to_i }
end

winnings = 0

sorted_hands = hands.sort_by do |hand|
  hand[:hand_points].unshift(hand[:hand_score])
end

# p sorted_hands

sorted_hands.each_with_index do |hand, index|
  winnings += hand[:bet] * (index + 1)
end

puts winnings

file.close
