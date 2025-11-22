# Seeds for Psalm Cycles
# Creates both weekly and monthly cycles
# TODO: Verify with LOC 2015 which cycle system is used and adjust accordingly

puts "Creating Psalm Cycles..."

# Weekly Cycle (Simple 7-day cycle)
# This is a simplified example - you should consult LOC 2015 for the official cycle

weekly_morning_psalms = {
  0 => [1, 2, 3],      # Sunday
  1 => [5, 6, 7],      # Monday
  2 => [9, 10, 11],    # Tuesday
  3 => [12, 13, 14],   # Wednesday
  4 => [15, 16, 17],   # Thursday
  5 => [18, 19, 20],   # Friday
  6 => [21, 22, 23]    # Saturday
}

weekly_evening_psalms = {
  0 => [8, 84, 150],   # Sunday
  1 => [24, 25, 26],   # Monday
  2 => [27, 28, 29],   # Tuesday
  3 => [30, 31, 32],   # Wednesday
  4 => [33, 34, 35],   # Thursday
  5 => [36, 37, 38],   # Friday
  6 => [39, 40, 41]    # Saturday
}

# Create weekly morning cycle
weekly_morning_psalms.each do |day, psalms|
  PsalmCycle.find_or_create_by!(
    cycle_type: 'weekly',
    week_number: nil,
    day_of_week: day,
    office_type: 'morning'
  ) do |pc|
    pc.psalm_numbers = psalms
    pc.notes = "Weekly cycle for #{Date::DAYNAMES[day]} Morning Prayer"
  end
end

# Create weekly evening cycle
weekly_evening_psalms.each do |day, psalms|
  PsalmCycle.find_or_create_by!(
    cycle_type: 'weekly',
    week_number: nil,
    day_of_week: day,
    office_type: 'evening'
  ) do |pc|
    pc.psalm_numbers = psalms
    pc.notes = "Weekly cycle for #{Date::DAYNAMES[day]} Evening Prayer"
  end
end

# Midday typically uses portions of Psalm 119 or fixed psalms
# Creating a simple rotation for midday
midday_psalms = [
  [119], # Sunday (can use different portions)
  [119], # Monday
  [119], # Tuesday
  [119], # Wednesday
  [119], # Thursday
  [119], # Friday
  [119]  # Saturday
]

midday_psalms.each_with_index do |psalms, day|
  PsalmCycle.find_or_create_by!(
    cycle_type: 'weekly',
    week_number: nil,
    day_of_week: day,
    office_type: 'midday'
  ) do |pc|
    pc.psalm_numbers = psalms
    pc.notes = "Midday Prayer for #{Date::DAYNAMES[day]}"
  end
end

# Compline uses fixed psalms every night: 4, 31, 91, 134
(0..6).each do |day|
  PsalmCycle.find_or_create_by!(
    cycle_type: 'weekly',
    week_number: nil,
    day_of_week: day,
    office_type: 'compline'
  ) do |pc|
    pc.psalm_numbers = [4, 31, 91, 134]
    pc.notes = "Compline psalms (fixed)"
  end
end

puts "Created #{PsalmCycle.count} psalm cycles (weekly)"
puts "NOTE: This is a simplified weekly cycle. Consult LOC 2015 for the official cycle."
puts "      LOC may use a 30-day (monthly) cycle instead. If so, you'll need to create 30 entries per office type."

# Monthly Cycle (30-day cycle) - Example structure
# Uncomment and populate if LOC 2015 uses monthly cycle

=begin
# Example for day 1 of monthly cycle
PsalmCycle.find_or_create_by!(
  cycle_type: 'monthly',
  week_number: nil,
  day_of_week: 1,  # Day 1 of the month
  office_type: 'morning'
) do |pc|
  pc.psalm_numbers = [1, 2, 3, 4, 5]
  pc.notes = "Day 1 Morning - monthly cycle"
end

PsalmCycle.find_or_create_by!(
  cycle_type: 'monthly',
  week_number: nil,
  day_of_week: 1,
  office_type: 'evening'
) do |pc|
  pc.psalm_numbers = [6, 7, 8]
  pc.notes = "Day 1 Evening - monthly cycle"
end

# Repeat for days 2-30...
=end
