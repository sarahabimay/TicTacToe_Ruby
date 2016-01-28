require "yn"
require "game_type"
require "board_options"

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
    type = console_ui.ask_player_for_game_type until GameType.is_valid_game_type?(type)
    type
  end

  def get_valid_dimension
      dimension = console_ui.ask_player_for_board_dimension until BoardOptions.is_valid_dimension?(dimension)
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
    choice = console_ui.ask_player_to_play_again until YN.is_valid_choice?(choice)
    
    return true if choice == YN::Y 
    return false if choice == YN::N 
  end
  
  private
  attr_reader :game, :game_maker, :console_ui
end