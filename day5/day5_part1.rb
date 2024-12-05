# Open the file
file = File.open('input.txt')
# Read the file
file_data = file.readlines.map(&:chomp)

ordering_rules = {}
sum = 0
is_ordering = true

def check_is_safe(pages, ordering_rules)
  is_safe = true
  pages[1..-1].each_with_index do |page, index|
    page_rules = ordering_rules[page]
    pages[0..index+1].each do |other_page|
      next unless page_rules
      return false if page_rules.include?(other_page)
    end
  end
  is_safe
end

file_data.each do |line|
  if line == ''
    is_ordering = false
    next
  end

  if is_ordering
    first_page, second_page = line.split('|').map(&:to_i)

    ordering_rules[first_page] ||= []
    ordering_rules[first_page] << second_page
  end

  unless is_ordering
    page_numbers = line.split(',').map(&:to_i)
    sum += page_numbers[page_numbers.length / 2] if check_is_safe(page_numbers, ordering_rules)
  end
end

puts sum

file.close
