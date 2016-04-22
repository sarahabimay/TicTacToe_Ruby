require "console_app"
require "console_game_maker"
require "console_ui"
require "stringio"

RSpec.describe ConsoleApp do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"]}
  let(:game_factory_spy) { instance_spy(ConsoleGameMaker)}
  let(:game_spy) { instance_spy(TicTacToe::Game) }
  let(:display_spy) { instance_spy(ConsoleUI) }
  let(:console) { ConsoleApp.new(game_factory_spy, display_spy) }
  HVH_GAME_TYPE = 1
  HVB_GAME_TYPE = 2
  BVH_GAME_TYPE = 3

  it "initialize a 3x3, HVH_GAME_TYPE game" do
    allow(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_spy).to receive(:game_type).and_return(HVH_GAME_TYPE)
    game = console.create_new_game_from_options(dimension, HVH_GAME_TYPE)
    expect(console.game_type).to eq(HVH_GAME_TYPE)
  end

  it "sets up the game and plays" do
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_spy).to receive(:play_turns).and_return(instance_spy(TicTacToe::Board))
    console.create_new_game_from_options(dimension, HVH_GAME_TYPE)
    console.play
  end

  it "user provides invalid game type" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("9", HVH_GAME_TYPE)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(dimension)
    expect(game_factory_spy).to receive(:create_game).with(dimension, HVH_GAME_TYPE).and_return(game_spy)
    console.initialize_game
  end

  it "user provides invalid board dimension" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return(HVH_GAME_TYPE)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("5", dimension)
    expect(game_factory_spy).to receive(:create_game).with(dimension, HVH_GAME_TYPE).and_return(game_spy)
    console.initialize_game
  end

  it "user provides valid game type: HVH_GAME_TYPE and board size: 3" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return(HVH_GAME_TYPE)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(dimension)
    expect(game_factory_spy).to receive(:create_game).with(dimension, HVH_GAME_TYPE).and_return(game_spy)
    console.initialize_game
  end

  it "user provides valid game type: BVH_GAME_TYPE and board size: 3" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return(BVH_GAME_TYPE)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(dimension)
    expect(game_factory_spy).to receive(:create_game).with(dimension, BVH_GAME_TYPE).and_return(game_spy)
    console.initialize_game
  end

  it "user provides valid game type: HVB_GAME_TYPE and board size: 3" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return(HVB_GAME_TYPE)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(dimension)
    expect(game_factory_spy).to receive(:create_game).with(dimension, HVB_GAME_TYPE).and_return(game_spy)
    console.initialize_game
  end

  it "user wants to replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(TicTacToe::YN::Y)
    expect(console.player_wants_to_play_again?).to eq(true)
  end

  it "user doesn't want to replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(TicTacToe::YN::N)
    expect(console.player_wants_to_play_again?).to eq(false)
  end

  it "user enters invalid response, then 'No' for replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return("blah", TicTacToe::YN::N)
    expect(console.player_wants_to_play_again?).to eq(false)
  end

  it "winning game results displayed" do
    board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::X, 9]])
    player1_spy = instance_spy(TicTacToe::HumanPlayer)
    player2_spy = instance_spy(TicTacToe::HumanPlayer)
    hvh_3x3_game = TicTacToe::Game.new(board, HVH_GAME_TYPE, display_spy, [player1_spy, player2_spy])
    expect(game_factory_spy).to receive(:create_game).and_return(hvh_3x3_game)
    console = ConsoleApp.new(game_factory_spy, display_spy)
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3")
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(TicTacToe::YN::N)
    expect(display_spy).to receive(:display_result) do |mark|
      expect(mark).to be(TicTacToe::Mark::X)
    end
    console.run
  end

  it "draw results displayed" do
    board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::O, TicTacToe::Mark::X], [TicTacToe::Mark::O, TicTacToe::Mark::O, TicTacToe::Mark::X], [TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O]])
    player1_spy = instance_spy(TicTacToe::HumanPlayer)
    player2_spy = instance_spy(TicTacToe::HumanPlayer)
    hvh_3x3_game = TicTacToe::Game.new(board, HVH_GAME_TYPE, display_spy, [player1_spy, player2_spy])
    expect(game_factory_spy).to receive(:create_game).and_return(hvh_3x3_game)
    console = ConsoleApp.new(game_factory_spy, display_spy)
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3")
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(TicTacToe::YN::N)
    expect(display_spy).to receive(:display_result) do |mark|
      expect(mark).to be(nil)
    end
    console.run
  end

  it "create a 3x3, HVH_GAME_TYPE game, asks for moves, asks to play again" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1", "1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3", "3")
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy, game_spy)
    board_spy = instance_spy(TicTacToe::Board)
    expect(game_spy).to receive(:play_turns).and_return(board_spy, board_spy)
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(TicTacToe::YN::Y, "rubbish_entered", TicTacToe::YN::N)
    console.run
  end
end
