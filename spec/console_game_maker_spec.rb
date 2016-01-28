require "console_game_maker"
require "stringio"

RSpec.describe ConsoleGameMaker do

  it "creates a game with 3x3 Board and HVH players" do
    input = StringIO.new
    output = StringIO.new
    console_ui = ConsoleUI.new(input, output)
    game_maker = ConsoleGameMaker.new(PlayerFactory.new(console_ui), console_ui)
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
    console_ui_spy = instance_spy(ConsoleUI)
    expect(console_ui_spy).to receive(:ask_player_for_move).and_return(1, 2)
    game_maker = ConsoleGameMaker.new(PlayerFactory.new(console_ui_spy), console_ui_spy)
    game = game_maker.create_game(BoardOptions::THREE_BY_THREE, GameType::HVH)
    players = game.players
    players.each do |player|
      expect(player[1].get_next_move).to be_a(Fixnum)
    end
  end
end
