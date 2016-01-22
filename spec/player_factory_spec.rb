require "player_factory"
require "stringio"

RSpec.describe PlayerFactory do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:display) { ConsoleDisplay.new(input, output) }
  it "creates a list of two players" do
    factory = PlayerFactory.new(display)
    expect(factory.players.length).to eq(2)
  end

  it "creates a list of two HumanPlayers" do
    factory = PlayerFactory.new(display)
    expect(factory.players[0]).to be_a(HumanPlayer)
    expect(factory.players[1]).to be_a(HumanPlayer)
  end
end
