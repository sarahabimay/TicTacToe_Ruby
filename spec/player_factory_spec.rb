require "player_factory"
require "stringio"

RSpec.describe PlayerFactory do
  let(:display) { ConsoleUI.new(StringIO.new, StringIO.new) }

  it "creates a list of two HumanPlayers" do
    factory = PlayerFactory.new(display)
    players = factory.get_players_for_game_type(GameTypeOptions::HVH)
    expect(players[Mark::X]).to be_a(HumanPlayer)
    expect(players[Mark::O]).to be_a(HumanPlayer)
  end

  it "creates a Human and Beatable AI Player for HVB games" do
    factory = PlayerFactory.new(display)
    players = factory.get_players_for_game_type(GameTypeOptions::HVB)
    expect(players[Mark::X]).to be_a(HumanPlayer)
    expect(players[Mark::O]).to be_a(BeatableAIPlayer)
  end

  it "creates a Beatable AI and Human player for BVH games" do
    factory = PlayerFactory.new(display)
    players = factory.get_players_for_game_type(GameTypeOptions::BVH)
    expect(players[Mark::X]).to be_a(BeatableAIPlayer)
    expect(players[Mark::O]).to be_a(HumanPlayer)
  end
end
