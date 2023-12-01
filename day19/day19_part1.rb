file = File.open('temp.txt')
file_data = file.readlines.map(&:chomp)

MINUTES = 24

bluepint_map = {}

file_data.each_with_index do |input_row, _row_index|
  blueprint_string, blueprint_info = input_row.split(':')
  blueprint_num = blueprint_string.scan(/\d+/).join('').to_i
  # p blueprint_num
  blueprint_data = blueprint_info.split('.')
  ore = blueprint_data[0].scan(/\d+/).join('').to_i
  # p ore
  clay = blueprint_data[1].scan(/\d+/).join('').to_i
  # p clay
  obsidian = blueprint_data[2].scan(/\d+/).map(&:to_i)
  # p obsidian
  geode = blueprint_data[3].scan(/\d+/).map(&:to_i)
  # p geode
  bluepint_map[blueprint_num] = {
    ore:,
    clay:,
    obsidian:,
    geode:
  }
end

bluepint_map.each do |blueprint_num, blueprint_cost|
  storage = {
    ore: 0,
    clay: 0,
    obsidian: 0,
    geode: 0
  }

  robots = {
    ore: 1,
    clay: 0,
    obsidian: 0,
    geode: 0
  }
  MINUTES.times do |minute|

    build = {
      ore: 0,
      clay: 0,
      obsidian: 0,
      geode: 0
    }
    # See what to do
    if robots[:clay].zero?
      build[:clay] += 1 if storage[:ore] >= blueprint_cost[:clay]
    end

    unless (robots[:clay]).zero?
      ores_needed, clay_needed = blueprint_cost[:obsidian]
      if storage[:ore] >= ores_needed && storage[:clay] >= clay_needed
        # if robots[:obsidian].zero?
        build[:obsidian] += 1
      elsif storage[:ore] >= [blueprint_cost[:ore], blueprint_cost[:clay]].min
        future_ores = storage[:ore]
        future_clay = storage[:clay]

        until future_ores == ores_needed || future_clay == clay_needed
          future_ores += robots[:ore]
          future_clay += robots[:clay]
        end

        if future_ores < ores_needed && blueprint_cost[:ore] <= storage[:ore]
          build[:ore] += 1
        elsif future_clay < clay_needed && blueprint_cost[:clay] <= storage[:ore]
          cycles_needed = 0
          until future_clay >= clay_needed
            future_clay += robots[:clay] + 1
            cycles_needed += 1
          end
          if cycles_needed > (future_ores - blueprint_cost[:clay] / robots[:ore])
            build[:clay] += 1
          end
        end
      end
    end

    unless (robots[:obsidian]).zero?
      ores_needed, obsidian_needed = blueprint_cost[:geode]
      if storage[:ore] >= ores_needed && storage[:obsidian] >= obsidian_needed
        build[:geode] += 1
      end
      # elsif storage[:ore] >= [blueprint_cost[:ore], blueprint_cost[:obsidian][0]].min
      #   future_ores = storage[:ore]
      #   future_obsidian = storage[:obsidian]

      #   until future_ores == ores_needed || future_obsidian == obsidian_needed
      #     future_ores += robots[:ore]
      #     future_obsidian += robots[:obsidian]
      #   end

      #   if future_ores < ores_needed && blueprint_cost[:ore] <= storage[:ore]
      #     build[:ore] += 1
      #   elsif future_obsidian < obsidian_needed && blueprint_cost[:obsidian][0] <= storage[:ore] && blueprint_cost[:obsidian][1] <= storage[:clay]
      #     cycles_needed = 0
      #     until future_clay >= clay_needed
      #       future_clay += robots[:clay] + 1
      #       cycles_needed += 1
      #     end
      #     if cycles_needed > (future_ores - blueprint_cost[:clay] / robots[:ore])
      #       build[:clay] += 1
      #     end
      #   end
      # elsif storage[:ore] >= [blueprint_cost[:ore], blueprint_cost[:clay]].min
      #   future_ores = storage[:ore]
      #   future_clay = storage[:clay]

      #   until future_ores == ores_needed || future_clay == clay_needed
      #     future_ores += robots[:ore]
      #     future_clay += robots[:clay]
      #   end

      #   if future_ores < ores_needed && blueprint_cost[:ore] <= storage[:ore]
      #     build[:ore] += 1
      #   elsif future_clay < clay_needed && blueprint_cost[:clay] <= storage[:ore]
      #     cycles_needed = 0
      #     until future_clay >= clay_needed
      #       future_clay += robots[:clay] + 1
      #       cycles_needed += 1
      #     end
      #     if cycles_needed > (future_ores - blueprint_cost[:clay] / robots[:ore])
      #       build[:clay] += 1
      #     end
      #   end
      # end
    end

    # Store
    storage[:ore] += robots[:ore]
    storage[:clay] += robots[:clay]
    storage[:obsidian] += robots[:obsidian]
    storage[:geode] += robots[:geode]

    # Build
    build.each do |key, value|
      next if value.zero?

      case key
      when :ore
        storage[:ore] -= blueprint_cost[:ore]
        robots[:ore] += 1
      when :clay
        storage[:ore] -= blueprint_cost[:clay]
        robots[:clay] += 1
      when :obsidian
        storage[:ore] -= blueprint_cost[:obsidian][0]
        storage[:clay] -= blueprint_cost[:obsidian][1]
        robots[:obsidian] += 1
      when :geode
        storage[:ore] -= blueprint_cost[:geode][0]
        storage[:obsidian] -= blueprint_cost[:geode][1]
        robots[:geode] += 1
      end
    end
    puts minute + 1
    p storage
    p robots
  end
end

file.close
