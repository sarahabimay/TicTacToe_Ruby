require_relative "../lib/human_player"
require "rspec"

class HumanPlayerTest
  describe HumanPlayer do
    it "create player with X mark" do
      human_player = HumanPlayer.new(Mark::X)
      expect(human_player.mark).to eq(Mark::X)
    end

    it "knows who it's opponent is" do
      human_player = HumanPlayer.new(Mark::X)
      expect(human_player.get_opponent).to eq(Mark::O)
    end
  end
end

