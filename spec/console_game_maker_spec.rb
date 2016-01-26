require "console_game_maker"
require "stringio"

RSpec.describe ConsoleGameMaker do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  it "creates a game with 3x3 Board and HVH players" do
    console_display = ConsoleDisplay.new(input, output)
    game_maker = ConsoleGameMaker.new(PlayerFactory.new(console_display), ConsoleBoardDisplayer.new(console_display))
    game = game_maker.create_game(BoardOptions::THREE_BY_THREE, GameType::HVH)
    expect(game).to be_a(Game)
    players = game.players
    expect(players.size).to eq(2)
    players.each do |player|
      expect(player[1]).to be_a(HumanPlayer)
      expect(Mark::is_a_mark?(player[1].mark)).to eq(true)
    end
  end

  it "creates a game and gets a move from each player"  do
    console_display_spy = instance_spy(ConsoleDisplay)
    expect(console_display_spy).to receive(:ask_player_for_move).and_return(1, 2)
    game_maker = ConsoleGameMaker.new(PlayerFactory.new(console_display_spy), ConsoleBoardDisplayer.new(console_display_spy))
    game = game_maker.create_game(BoardOptions::THREE_BY_THREE, GameType::HVH)
    players = game.players
    players.each do |player|
      expect(player[1].get_next_move).to be_a(Fixnum)
    end
  end
end
