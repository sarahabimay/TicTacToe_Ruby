require "player"

class BeatableAIPlayer
  include Player

  def initialize(mark, display)
    @mark = mark
    @display = display
  end

  def get_next_move
    move = rand(1..9)
    display.announce_player_move(mark, move)
    move
  end

  private

  attr_reader :mark, :display
end
