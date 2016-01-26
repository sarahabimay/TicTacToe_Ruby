require "human_player"

class PlayerFactory
  attr_reader :players
  
  def initialize(display)
    @players = []
    @display = display
  end
  
  def get_players_for_game_type(game_type)
    case game_type
    when GameType::HVH
      @players = [HumanPlayer.new(Mark::X, @display), HumanPlayer.new(Mark::O, @display)]
    end
    @players
  end
  
end
