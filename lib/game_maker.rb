class GameMaker
  def initialize(player_factory)
    @player_factory = player_factory 
  end

  def create_game(board_dimension, game_type)
    Game.new(Board.new(board_dimension), game_type, @player_factory.players)
  end
end
