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

    unless check_is_safe(page_numbers, ordering_rules)
      reorder_page_numbers = page_numbers.sort do |a, b|
        if ordering_rules[b] && ordering_rules[b].include?(a)
          -1
        elsif ordering_rules[a] && ordering_rules[a].include?(b)
          1
        else
          0
        end
      end
      sum += reorder_page_numbers[reorder_page_numbers.length / 2]
    end
  end
end

puts sum

file.close
