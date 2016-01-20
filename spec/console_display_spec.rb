require_relative "../lib/console_display"
require_relative "../lib/board"
require "rspec"
require "stringio"


class ConsoleDisplayTest
  describe ConsoleDisplay do
    let(:console_display) { ConsoleDisplay.new($stdin, $stdout) }
    
    it "asks user for a move" do
      expect(STDOUT).to receive(:puts).with("Please choose a position Player X:\n")
      #allow(STDIN).to receive(:gets) { Mark::X }
      console_display.ask_player_for_move(Board.new(3))
    end

    it "gets a move from user" do
      allow(STDIN).to receive(:gets) { 1 }
      console_display.ask_player_for_move(Board.new(3))
      expect(console_display.ask_player_for_move(Board.new(3))).to eq(1) 
    end

    it "displays winner announcement" do
      expect(STDOUT).to receive(:puts).with("We have a winner: Player X!\n")
      console_display.display_result(Mark::X)
    end

    it "displays draw announcement" do
      expect(STDOUT).to receive(:puts).with("The game is a draw!\n")
      console_display.display_result(nil)
    end

    it "asks user if they want to play again" do
      expect(STDOUT).to receive(:puts).with("Do you want to play again? Yes(1) or No(2)?\n")
      console_display.ask_player_to_play_again
    end

    it "gets user's play again choice" do
      allow(STDIN).to receive(:gets) { 1 }
      expect(console_display.ask_player_to_play_again).to eq(1)
    end

    it "displays TTT board on the console" do
      board = Board.new(3, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
      expect(STDOUT).to receive(:puts)
      console_display.display_board(board)
    end

    it "formats board" do
      board = Board.new(3, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
      results = console_display.format_board_for_display(board)
      expect(results).to eq("X|O|X\nX|O|X\nO|X|O")
    end
  end
end
