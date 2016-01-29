require "console_ui"
require "game_type_options"
require "board"
require "board_options"
require "stringio"

RSpec.describe ConsoleUI do
  REQUEST_GAME_TYPE = "Please choose game type:"
  REQUEST_BOARD_DIMENSION = "Please choose board dimension: 3x3(3).\n"
  NEW_MOVE_REQUEST = "Please choose a position"
  PLAY_AGAIN_REQUEST = "Do you want to play a game of TIC TAC TOE? Yes(1) or No(2)?\n"
  WINNING_ANOUNCEMENT = "We have a winner:"
  DRAW_ANNOUNCEMENT = "The game is a draw!\n"

  let(:output) { StringIO.new }
  let(:console_ui) { ConsoleUI.new(StringIO.new("1"), output) }

  it "request board size from player" do
    console_ui.ask_player_for_board_dimension
    expect(output.string).to eq(REQUEST_BOARD_DIMENSION)
  end

  it "gets board size from player" do
    dimension = StringIO.new("3") 
    console = ConsoleUI.new(dimension, output)
    expect(console.ask_player_for_board_dimension).to eq("3") 
  end

  it "request game type from player" do
    console_ui.ask_player_for_game_type
    expect(output.string).to eq("#{REQUEST_GAME_TYPE}\n#{HVH_OPTION} ; #{HVB_OPTION} ; #{BVH_OPTION}\n")
  end

  it "request game type from player" do
    hvh_game_input = StringIO.new("1") 
    console = ConsoleUI.new(hvh_game_input, output)
    expect(console.ask_player_for_game_type).to eq("1") 
  end

  it "asks user for a move" do
    console_ui.ask_player_for_move(Mark::X)
    expect(output.string).to eq("#{NEW_MOVE_REQUEST} Player X:\n")
  end

  it "gets a move from user" do
    move_input = StringIO.new("1") 
    console = ConsoleUI.new(move_input, output)
    expect(console.ask_player_for_move(Board.new(3))).to eq("1") 
  end

  it "displays user move to console" do
    console_ui.announce_player_move(Mark::X, "1")
    expect(output.string).to eq("Player: X has selected: 1\n")
  end

  it "displays winner announcement" do
    console_ui.display_result(Mark::X)
    expect(output.string).to eq("#{WINNING_ANOUNCEMENT} Player X!\n")
  end

  it "displays draw announcement" do
    console_ui.display_result(nil)
    expect(output.string).to eq(DRAW_ANNOUNCEMENT)
  end

  it "asks user if they want to play again" do
    console_ui.ask_player_to_play_again
    expect(output.string).to eq(PLAY_AGAIN_REQUEST)
  end

  it "gets user's play again choice as Yes" do
    yes_input = StringIO.new(YN::Y) 
    console = ConsoleUI.new(yes_input, output)
    expect(console_ui.ask_player_to_play_again).to eq(YN::Y) 
  end

  it "gets user's play again choice as N" do
    no_input = StringIO.new(YN::N) 
    console = ConsoleUI.new(no_input, output)
    expect(console.ask_player_to_play_again).to eq(YN::N) 
  end

  it "gets user's play again choice as invalid" do
    invalid_input = StringIO.new("rubbish") 
    console = ConsoleUI.new(invalid_input, output)
    expect(choice = console.ask_player_to_play_again).to eq("rubbish") 
    expect(YN.is_valid_choice?(choice)).to eq(false)
  end

  it "displays TTT board on the console" do
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
    console_ui.display_board(board)
    expect(output.string).to eq("X|O|X\nX|O|X\nO|X|O\n")
  end

  it "formats board" do
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
    results = console_ui.format_board_for_display(board)
    expect(results).to eq("X|O|X\nX|O|X\nO|X|O")
  end
end
