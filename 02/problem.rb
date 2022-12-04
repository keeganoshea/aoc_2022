# https://adventofcode.com/2022/day/2

CONVERSION =
   {
  "A": 1, #rock
  "X": 1, #rock
  "B": 2, #paper
  "Y": 2, #paper
  "C": 3, #scissors
  "Z": 3  #scissors
}

INPUT = File.read(ARGV[0])
sets = INPUT.split("\n").map{|set| set.split(",")}.map{|set| set[0].gsub(" ", ",")}

def convert(sets)
  sets.map do |s|
    s.split(",").map do |i|
      CONVERSION[i.to_sym]
    end
  end
end
converted_sets = convert(sets)

class Game
  def initialize(rounds)
    @win_points = [0, 0]
    @draw_points = [0, 0]
    @shape_points = [0, 0]
    @rounds = rounds
  end

  def play_game
    @rounds.each do |round|
      if round.uniq.length == 1
        @draw_points[0] += 3
        @draw_points[1] += 3
        @shape_points[0] += round.min
        @shape_points[1] += round.min
      elsif round.sum == 3
        winner = round.index(2)
        loser = round.index(1)
        @win_points[winner] += 6
        @shape_points[winner] += 2
        @shape_points[loser] += 1
      elsif round.sum == 4
        winner = round.index(1)
        loser = round.index(3)
        @win_points[winner] += 6
        @shape_points[winner] += 1
        @shape_points[loser] += 3
      elsif round.sum == 5
        winner = round.index(3)
        loser = round.index(2)
        @win_points[winner] += 6
        @shape_points[winner] += 3
        @shape_points[loser] += 2
      end
    end
  end

  def play_game_with_strategy
    @rounds.each do |round|
      if round[1] == 1 # lose
        winner = 0
        loser = 1
        @win_points[winner] += 6
        @shape_points[winner] += round[0]
        shape_to_lose_to = round[0]
        @shape_points[loser] += loser_points(shape_to_lose_to)
      elsif round[1] == 2 # draw
        @draw_points[0] += 3
        @draw_points[1] += 3
        @shape_points[0] += round[0]
        @shape_points[1] += round[0]
      elsif round[1] == 3 # win
        loser = 0
        winner = 1
        @win_points[winner] += 6
        @shape_points[loser] += round[0]
        shape_to_beat = round[0]
        @shape_points[winner] += winner_points(shape_to_beat)
      end
    end
  end

  def winner_points(shape_to_beat)
    case shape_to_beat
    when 1
      2
    when 2
      3
    when 3
      1
    end
  end

  def loser_points(shape_to_lose_to)
    case shape_to_lose_to
    when 1
      3
    when 2
      1
    when 3
      2
    end
  end

  def final_score(player)
    @win_points[player] + @shape_points[player] + @draw_points[player]
  end
end

game = Game.new(converted_sets)
game.play_game
game_2 = Game.new(converted_sets)
game_2.play_game_with_strategy

puts "Round 1: #{game.final_score(1)}"
puts "Round 2: #{game_2.final_score(1)}"




