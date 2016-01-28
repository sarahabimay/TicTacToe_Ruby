require "console_app"
require "stringio"

RSpec.describe ConsoleApp do
  let(:game_factory_spy) { instance_spy(ConsoleGameMaker)}
  let(:game_spy) { instance_spy(Game) }
  let(:board_spy) { instance_spy(Board) }
  let(:display_spy) { instance_spy(ConsoleUI) }
  let(:player1_spy) { instance_spy(HumanPlayer) }
  let(:player2_spy) { instance_spy(HumanPlayer) }
  let(:console) { ConsoleApp.new(game_factory_spy, display_spy) }

  it "initialize a 3x3, HVH game" do
    allow(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_spy).to receive(:game_type).and_return(GameTypeOptions::HVH)
    game = console.create_new_game_from_options(BoardOptions::THREE_BY_THREE, GameTypeOptions::HVH)
    expect(console.game_type).to eq(GameTypeOptions::HVH)
  end

  it "sets up the game and plays" do
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy)
    expect(game_spy).to receive(:play_turns).and_return(board_spy)
    console.create_new_game_from_options(BoardOptions::THREE_BY_THREE, GameTypeOptions::HVH)
    console.play
  end

  it "user provides invalid game type" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("9", GameTypeOptions::HVH)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(BoardOptions::THREE_BY_THREE)
    expect(game_factory_spy).to receive(:create_game).with(BoardOptions::THREE_BY_THREE, GameTypeOptions::HVH).and_return(game_spy)
    console.initialize_game
  end

  it "user provides invalid board dimension" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return(GameTypeOptions::HVH)
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("5", BoardOptions::THREE_BY_THREE)
    expect(game_factory_spy).to receive(:create_game).with(BoardOptions::THREE_BY_THREE, GameTypeOptions::HVH).and_return(game_spy)
    console.initialize_game
  end

  [GameTypeOptions::HVH, GameTypeOptions::BVH, GameTypeOptions::HVB].map do |game_type|
    it "user provides valid game type: #{game_type} and board size: 3" do
      expect(display_spy).to receive(:ask_player_for_game_type).and_return(game_type)
      expect(display_spy).to receive(:ask_player_for_board_dimension).and_return(BoardOptions::THREE_BY_THREE)
      expect(game_factory_spy).to receive(:create_game).with(BoardOptions::THREE_BY_THREE, game_type).and_return(game_spy)
      console.initialize_game
    end
  end

  it "user wants to replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(YN::Y) 
    expect(console.player_wants_to_play_again?).to eq(true)
  end

  it "user doesn't want to replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(YN::N) 
    expect(console.player_wants_to_play_again?).to eq(false)
  end

  it "user enters invalid response, then 'No' for replay" do
    expect(display_spy).to receive(:ask_player_to_play_again).and_return("blah", YN::N) 
    expect(console.player_wants_to_play_again?).to eq(false)
  end

  it "winning game results displayed" do 
    board = Board.new(3, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, Mark::O], [Mark::O, Mark::X, 9]])
    hvh_3x3_game = Game.new(board, GameTypeOptions::HVH, display_spy, [player1_spy, player2_spy])
    expect(game_factory_spy).to receive(:create_game).and_return(hvh_3x3_game)
    console = ConsoleApp.new(game_factory_spy, display_spy) 
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3")
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(YN::N) 
    expect(display_spy).to receive(:display_result) do |mark|
      expect(mark).to be(Mark::X)
    end
    console.run
  end

  it "draw results displayed" do 
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::O, Mark::X], [Mark::O, Mark::O, Mark::X], [Mark::X, Mark::X, Mark::O]])
    hvh_3x3_game = Game.new(board, GameTypeOptions::HVH, display_spy, [player1_spy, player2_spy])
    expect(game_factory_spy).to receive(:create_game).and_return(hvh_3x3_game)
    console = ConsoleApp.new(game_factory_spy, display_spy) 
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3")
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(YN::N) 
    expect(display_spy).to receive(:display_result) do |mark|
      expect(mark).to be(nil)
    end
    console.run
  end

  it "create a 3x3, HVH game, asks for moves, asks to play again" do
    expect(display_spy).to receive(:ask_player_for_game_type).and_return("1", "1")
    expect(display_spy).to receive(:ask_player_for_board_dimension).and_return("3", "3")
    expect(game_factory_spy).to receive(:create_game).and_return(game_spy, game_spy)
    expect(game_spy).to receive(:play_turns).and_return(board_spy, board_spy)
    expect(display_spy).to receive(:ask_player_to_play_again).and_return(YN::Y, "rubbish_entered", YN::N) 
    console.run
  end
end
