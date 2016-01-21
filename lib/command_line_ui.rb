class CommandLineUI
  def initialize(game_maker, console_display)
    @game_maker = game_maker
    @console_display = console_display
    @game = nil
  end

  def create_new_game_from_options(dimension_choice, game_type_choice)
    @game = @game_maker.create_game(dimension_choice, game_type_choice)
  end

  def game_type
    @game.game_type
  end
end
