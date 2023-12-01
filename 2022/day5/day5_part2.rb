file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

# To keep things simple, we will assume that there are only 9 stacks
NUMBER_OF_STACKS = 9

stacks = {}
# Generate the empty stacks
(1..NUMBER_OF_STACKS).each do |num|
  stacks[num] = []
end

top_values = []
is_movement_data = false

file_data.each do |input_row|
  if input_row == ''
    # This denotes the end of data input, the rest of the input_rows are moves
    is_movement_data = true

    # We have insert the data from top to bottom, hence we need to reverse the array to form the stack
    stacks.each do |key, value|
      stacks[key] = value.reverse
    end
  elsif !is_movement_data
    # Data input of the stack occurs here

    # We slice the data into 4 to obtain each block
    # blocks is [[],[], .... []] Array of 9 arrays
    blocks = input_row.chars.each_slice(4).map do |chars|
      # Remove the spaces and brackets
      chars.reject do |char|
        char == ' ' || char == '[' || char == ']'
      end
    end

    # If the first block is 1, we don't need to put the data into the block
    # Remember that numbers denotes the stack number
    next if blocks.first == ['1']

    # Push the respective letters into their respective stacks
    blocks.each_with_index do |block, index|
      stacks[index + 1].push(block.first) unless block == []
    end
  else
    data = input_row.split
    move = data[1].to_i
    from = data[3].to_i
    to = data[5].to_i

    temp_items = []
    # Move all the items into the temporary array
    move.times do
      item = stacks[from].pop # E.g. item = 1,2,3
      temp_items.push(item) # E.g. temp_items = [1,2,3]
    end

    # Push the temporary array into the new stack
    # Revers the temp_items array so that items will be inserted 3,2,1
    temp_items.reverse.each do |item|
      stacks[to].push(item)
    end
  end
end

# Obtain the top values of all the stacks
stacks.each do |_key, value|
  top_values.push(value.last)
end

puts top_values.join

file.close
