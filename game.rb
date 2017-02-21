require_relative 'player'
require_relative 'die'
require_relative 'game_turn'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play(rounds)
    puts "There are #{@players.size} players in #{@title}:"
    
    @players.each do |player|
      puts player
    end

    treasures = TreasureTrove::TREASURES

    puts "\nThere are #{treasures.size} treasures to be found:"
    
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

    1.upto(rounds) do |round|
      puts "\nRound #{round}"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def print_stats
    strong_players, wimpy_players = @players.partition { |player| player.strong? }
    puts "\n#{@title} Statitics:"

    puts "\n#{strong_players.count} strong players:"
    strong_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{wimpy_players.count} wimpy players:\n"
    wimpy_players.each do |player|
      print_name_and_health(player)
    end
  
    puts "\n#{@title} High Scores:"
    @players.sort.each { |player| puts "#{player.name.ljust(20, '.')} #{player.score}"}

    @players.each do |player|
      puts "\n#{player.name}'s point totals:"
      puts "#{player.points} grand total points"
    end

    puts "\n#{total_points} total points from treasures found"
  end

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def total_points
    @players.reduce(0) do |sum, player|
      sum + player.points
    end
  end
end