class ConsoleBoardDisplayer
  def initialize(display)
    @display = display
  end
  
  def display_board(board)
    @display.display_board(board)
  end
end
