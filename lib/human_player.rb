require_relative "mark.rb"

class HumanPlayer
  attr_reader :mark
  def initialize(mark)
    @mark = mark
  end

  def get_opponent
    Mark::X if @mark == Mark::O 
    Mark::O if @mark == Mark::X 
  end
end
