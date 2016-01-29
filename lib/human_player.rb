require "mark"
require "player"

class HumanPlayer
  include Player
 # attr_reader :mark

  def initialize(mark, display)
    @mark = mark
    @display = display
  end

  def get_next_move
    display.ask_player_for_move(mark)
  end

  private

  attr_reader :display, :mark
end
