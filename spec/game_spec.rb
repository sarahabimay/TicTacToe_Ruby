require_relative "../lib/game"
require_relative "./human_player_fake"
require "rspec"

class GameTest 
  HUMAN_HUMAN_TYPE = "HVH"

  describe Game do
    let(:display) { ConsoleDisplay.new($stdin, $stdout) }
    let(:game) { Game.new(Board.new(3), HUMAN_HUMAN_TYPE, [HumanPlayer.new(Mark::X, display), HumanPlayer.new(Mark::O, display)]) } 

    it "game has two players" do
      expect(game.players.length).to eq(2)
    end
    
    it "find player using Mark::O" do
      expect(game.find_player_by_mark(Mark::X)).to be_a(HumanPlayer)
    end

    it "find player using Mark::X" do
      expect(game.find_player_by_mark(Mark::X)).to be_a(HumanPlayer)
    end

    it "keeps playing until game over" do
      board = Board.new(3, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
      dummy_player_x = HumanPlayerFake.new(Mark::X, display)
      dummy_player_o = HumanPlayerFake.new(Mark::O, display)
      dummy_player_o.set_dummy_moves([6])
      dummy_player_x.set_dummy_moves([8])
      game = Game.new(board, HUMAN_HUMAN_TYPE, [dummy_player_x, dummy_player_o])
      board = game.play_turns
      expect(board.is_game_over?).to eq(true)
    end
  end
end
