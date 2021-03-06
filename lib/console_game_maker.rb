require "tictactoe/game"
require "tictactoe/board"
require "tictactoe/player_factory"

class ConsoleGameMaker
  def initialize(player_factory, board_displayer)
    @player_factory = player_factory
    @board_displayer = board_displayer
  end

  def create_game(board_dimension, game_type)
    TicTacToe::Game.new(TicTacToe::Board.new(board_dimension.to_i), game_type, board_displayer, player_factory.get_players_for_game_type(game_type))
  end

  private

  attr_reader :player_factory, :board_displayer
end
