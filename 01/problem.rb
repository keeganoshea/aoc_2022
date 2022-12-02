# This list represents the Calories of the food carried by five Elves:

# The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
# The second Elf is carrying one food item with 4000 Calories.
# The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
# The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
# The fifth Elf is carrying one food item with 10000 Calories.
# In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: they'd like to know how many Calories are being carried by the Elf carrying the most Calories. In the example above, this is 24000 (carried by the fourth Elf).

# Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?

INPUT = File.read(ARGV[0]).split("\n\n").map{|set| set.split("\n").map(&:to_i)}

class Elf
  def initialize(*calories)
    @calories = calories.flatten
  end

  def total_calories
    @calories.sum
  end
end

elves = INPUT.map do |set|
  Elf.new(set)
end

# solution 1
winning_elf = elves.map(&:total_calories).max
puts winning_elf

# solution 2
top_3 = elves.map(&:total_calories).sort.last(3).sum
puts top_3


