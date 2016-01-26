class ConsoleBoardDisplayer
  def initialize(display)
    @display = display
  end
  
  def display_board(board)
    display.display_board(board)
  end

  private
  attr_reader :display
end
