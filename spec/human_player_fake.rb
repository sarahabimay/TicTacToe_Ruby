require "human_player"

class HumanPlayerFake < HumanPlayer
  def set_dummy_moves(moves)
    @dummy_moves = moves
  end

  def get_next_position
    @dummy_moves.pop
  end
end
