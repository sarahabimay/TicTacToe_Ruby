require "game_maker"
require "stringio"

RSpec.describe GameMaker do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  it "creates a game with 3x3 Board and HVH players" do
    game_maker = GameMaker.new(PlayerFactory.new(ConsoleDisplay.new(input, output)))
    game = game_maker.create_game(BoardOptions::THREE, GameType::HVH)
    expect(game).to be_a(Game)
    players = game.players
    expect(players.size).to eq(2)
    players.each do |player|
      expect(player[1]).to be_a(HumanPlayer)
    end
  end
end
