module Player
  def get_opponent_mark
    Mark::X if mark == Mark::O 
    Mark::O if mark == Mark::X 
  end

  private 

  attr_reader :mark
end
