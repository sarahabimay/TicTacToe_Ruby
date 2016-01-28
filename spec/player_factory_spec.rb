require "player_factory"
require "stringio"

RSpec.describe PlayerFactory do
  let(:display) { ConsoleUI.new(StringIO.new, StringIO.new) }

  it "creates a list of two HumanPlayers" do
    factory = PlayerFactory.new(display)
    players = factory.get_players_for_game_type(GameType::HVH)
    expect(players[Mark::X]).to be_a(HumanPlayer)
    expect(players[Mark::O]).to be_a(HumanPlayer)
  end
end
