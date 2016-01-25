require "console_board_displayer"
require "board"
require "stringio"

RSpec.describe ConsoleBoardDisplayer do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  it "displays board to the console" do
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::O, Mark::X], [Mark::X, Mark::O, Mark::X], [Mark::O, Mark::X, Mark::O]])
    board_displayer = ConsoleBoardDisplayer.new(ConsoleDisplay.new(input, output)) 
    board_displayer.display_board(board)
    expect(output.string).to eq("X|O|X\nX|O|X\nO|X|O\n")
  end
end
