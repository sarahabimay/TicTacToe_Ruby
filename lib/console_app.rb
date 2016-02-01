require "tictactoe/yn"
require "tictactoe/game_type_options"
require "tictactoe/board_options"

class ConsoleApp
  def initialize(game_maker, console_ui)
    @game_maker = game_maker
    @console_ui = console_ui
  end

  def game_type
    @game.game_type
  end

  def run
    play_again_choice = true 
    while(play_again_choice) do
      initialize_game
      play
      display_result
      play_again_choice = player_wants_to_play_again?
    end
  end

  def initialize_game
    game_type_choice = get_valid_game_type
    dimension_choice = get_valid_dimension
    create_new_game_from_options(dimension_choice, game_type_choice)
  end

  def get_valid_game_type
    type = console_ui.ask_player_for_game_type until TicTacToe::GameTypeOptions.is_valid_game_type?(type)
    type
  end

  def get_valid_dimension
      dimension = console_ui.ask_player_for_board_dimension until TicTacToe::BoardOptions.is_valid_dimension?(dimension)
      dimension
  end

  def create_new_game_from_options(dimension_choice, game_type_choice)
    @game = game_maker.create_game(dimension_choice, game_type_choice)
  end

  def play
    @game.play_turns
  end

  def display_result
    console_ui.display_result(@game.get_winning_mark)
  end

  def player_wants_to_play_again?
    choice = console_ui.ask_player_to_play_again until TicTacToe::YN.is_valid_choice?(choice)
    return true if choice == TicTacToe::YN::Y 
    return false if choice == TicTacToe::YN::N 
  end
  
  private

  attr_reader :game, :game_maker, :console_ui
end
