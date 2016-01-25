class GameMaker
  def initialize(player_factory)
    @player_factory = player_factory 
  end

  def create_game(board_dimension, game_type)
    Game.new(Board.new(board_dimension), game_type, @player_factory.get_players_for_game_type(game_type))
  end
end
