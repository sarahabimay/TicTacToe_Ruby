require_relative "../lib/player_factory"
require "rspec"

class PlayerFactoryTest
  describe PlayerFactory do
    it "creates a list of two players" do
      factory = PlayerFactory.new
      expect(factory.players.length).to eq(2)
    end

    it "creates a list of two HumanPlayers" do
      factory = PlayerFactory.new
      expect(factory.players[0]).to be_a(HumanPlayer)
      expect(factory.players[1]).to be_a(HumanPlayer)
    end
  end
end
