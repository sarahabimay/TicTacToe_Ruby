module Player
  def initialize(mark)
    @mark = mark
  end

  def get_opponent_mark
    Mark::X if mark == Mark::O 
    Mark::O if mark == Mark::X 
  end

  attr_reader :mark
end
