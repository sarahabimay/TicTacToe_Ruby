require "human_player"

class PlayerFactory
  
  def initialize(display)
    @players = []
    @display = display
  end
  
  def get_players_for_game_type(game_type)
    case game_type
    when GameType::HVH
      players = Hash[Mark::X, HumanPlayer.new(Mark::X, display), Mark::O, HumanPlayer.new(Mark::O, display)]
    end
    players
  end
  
  private
  attr_reader :display, :players
end
