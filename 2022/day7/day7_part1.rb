file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

MAX_VALUE = 100_000

directories = {}
dir_file_size = {}
total = 0
cumilative_file_size = 0
path = []
current_directory = ''

# When we are processing the data, we shall assume that all commands are valid
file_data.each do |input_row|
  data = input_row.split
  if input_row.start_with?('$') # These are commands either cd or ls
    # Save the file size of the current directory
    if cumilative_file_size.positive?
      dir_file_size[current_directory] = cumilative_file_size
      cumilative_file_size = 0
    end

    if data[1] == 'cd' && data[2] != '..' # Going into a particular directory
      # Update the current path
      path.push(data[2])
      current_directory = path.join('/')
      directories[current_directory] = []
    elsif data[1] == 'cd' && data[2] == '..' # Going out of a directory
      path.pop
    end
  elsif input_row.start_with?('dir') # These are directory information
    # Update the directory information
    directories[current_directory].push("#{current_directory}/#{data[1]}")
  else
    # Update the total size of the files
    cumilative_file_size += data[0].to_i
  end
end

# To handle the case where the end of input is the ls command
if cumilative_file_size.positive?
  dir_file_size[current_directory] = cumilative_file_size
  cumilative_file_size = 0
end

# This is a recursive method
def compute_dir_size(name, size, directories, dir_file_size)
  # If the directory has no size, we give it 0
  # This can occur if a directory has no files
  total_dir_size = size || 0

  # The &. ensures that it exist before executing
  # directors[name] will return an array of sub directories
  directories[name]&.each do |sub_dir|
    # Get the size of the sub directories
    total_dir_size += compute_dir_size(sub_dir, dir_file_size[sub_dir], directories, dir_file_size)
  end

  # return the total size
  total_dir_size
end

directories.each do |name, _sub_dir|
  dir_size = compute_dir_size(name, dir_file_size[name], directories, dir_file_size)
  # We only get the sum of the directories which are less than a certain value
  total += dir_size if dir_size < MAX_VALUE
end

puts total
