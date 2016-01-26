require "player_factory"
require "stringio"

RSpec.describe PlayerFactory do
  let(:display) { ConsoleDisplay.new(StringIO.new, StringIO.new) }

  it "creates a list of two players" do
    factory = PlayerFactory.new(display)
    expect(factory.players.length).to eq(0)
  end

  it "creates a list of two HumanPlayers" do
    factory = PlayerFactory.new(display)
    players = factory.get_players_for_game_type(GameType::HVH)
    expect(players[0]).to be_a(HumanPlayer)
    expect(players[1]).to be_a(HumanPlayer)
  end
end
