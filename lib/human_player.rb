require "mark"

class HumanPlayer
  attr_reader :mark

  def initialize(mark, display)
    @mark = mark
    @display = display
  end

  def get_opponent
    Mark::X if mark == Mark::O 
    Mark::O if mark == Mark::X 
  end

  def get_next_move
    display.ask_player_for_move(mark)
  end

  private
  attr_reader :display
end
