require 'byebug'
require_relative 'player.rb'

class Game


  def initialize(player_1, player_2, dictionary)
    @current_player, @previous_player = player_1, player_2
    @fragment = ""
    @dictionary = dictionary

    @losses = Hash.new(0)
  end

  def next_player!
    @current_player, @previous_player =
      @previous_player, @current_player
  end

  def take_turn(player)
    ch = player.guess
    valid_play?(ch) ? @fragment += ch : add_loss
  end

  def valid_play?(ch)
    return false if ch == ""
    temp = @fragment + ch
    @dictionary.any? { |word| word[0...temp.length] == temp }
  end

  def record(player)
    ghost = "GHOST"
    loss_count = @losses[player]
    ghost[0...loss_count]
  end

  def play_round
#debugger

    until word_created?
      next_player!
      good_play = take_turn(@current_player)
      display
      break unless good_play
    end
    add_loss if word_created?
  end

  def add_loss
    @losses[@current_player] += 1
    p "#{@current_player.name} gets #{record(@current_player)}"
    @fragment = ""
    false
  end


  def run
    until @losses.has_value?(5)
      play_round
    end
    p "Whoops #{@current_player.name} you lost!"
  end


  def word_created?
    @dictionary.include?(@fragment)
  end

  def display
    p @fragment
  end

end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("dictionary.txt")
  dictionary.map! { |line| line.chomp }
  player_one = Player.new("Jonathan")
  player_two = Player.new("Sean")
  game = Game.new(player_one, player_two, dictionary)
  game.run
end
