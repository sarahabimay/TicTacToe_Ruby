require "console_display"
require "board"
require "stringio"

RSpec.describe ConsoleDisplay do
  REQUEST_BOARD_DIMENSION = "Please choose board dimension: 3x3(3).\n"
  REQUEST_GAME_TYPE = "Please choose game type: Human vs Human(1).\n"
  NEW_MOVE_REQUEST = "Please choose a position"
  PLAY_A_GAME_REQUEST = "Do you want to play a game of TIC TAC TOE? Yes(1) or No(2)?\n"
  WINNING_ANNOUNCEMENT = "We have a winner:"
  DRAW_ANNOUNCEMENT = "The game is a draw!\n"

  let(:input) { StringIO.new("1") }
  let(:output) { StringIO.new }
  let(:console_display) { ConsoleDisplay.new(input, output) }

  it "request board size from player" do
    console_display.ask_player_for_board_dimension
    expect(output.string).to eq(REQUEST_BOARD_DIMENSION)
  end

  it "gets board size from player" do
    dimension = StringIO.new("3") 
    console = ConsoleDisplay.new(dimension, output)
    expect(console.ask_player_for_board_dimension).to eq("3") 
  end

  it "request game type from player" do
    console_display.ask_player_for_game_type
    expect(output.string).to eq(REQUEST_GAME_TYPE)
  end

  it "request game type from player" do
    hvh_game = StringIO.new("1") 
    console = ConsoleDisplay.new(hvh_game, output)
    expect(console.ask_player_for_game_type).to eq("1") 
  end

  it "asks user for a move" do
    console_display.ask_player_for_move(Board.new(3))
    expect(output.string).to eq("#{NEW_MOVE_REQUEST} Player X:\n")
  end

  it "gets a move from user" do
    move_input = StringIO.new("1") 
    console = ConsoleDisplay.new(move_input, output)
    expect(console.ask_player_for_move(Board.new(3))).to eq("1") 
  end

  it "displays winner announcement" do
    console_display.display_result(Mark::X)
    expect(output.string).to eq("#{WINNING_ANNOUNCEMENT} Player X!\n")
  end

  it "displays draw announcement" do
    console_display.display_result(nil)
    expect(output.string).to eq(DRAW_ANNOUNCEMENT)
  end

  it "asks user if they want to play again" do
    console_display.ask_player_to_play_again
    expect(output.string).to eq(PLAY_A_GAME_REQUEST)
  end

  it "gets user's play again choice as Yes" do
    yes_input = StringIO.new(YN::Y) 
    console = ConsoleDisplay.new(yes_input, output)
    expect(console_display.ask_player_to_play_again).to eq(YN::Y) 
  end

  it "gets user's play again choice as N" do
    no_input = StringIO.new(YN::N) 
    console = ConsoleDisplay.new(no_input, output)
    expect(console.ask_player_to_play_again).to eq(YN::N) 
  end

  it "gets user's play again choice as invalid" do
    invalid_input = StringIO.new("rubbish") 
    console = ConsoleDisplay.new(invalid_input, output)
    expect(choice = console.ask_player_to_play_again).to eq("rubbish") 
    expect(YN.is_valid_choice?(choice)).to eq(false)
  end

  it "displays TTT board on the console" do
    board = Board.new(3, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
    console_display.display_board(board)
    expect(output.string).to eq("X|O|X\nX|O|X\nO|X|O\n")
  end

  it "formats board" do
    board = Board.new(3, [[Mark::X, Mark::O, Mark::X],[Mark::X, Mark::O, Mark::X],[Mark::O, Mark::X, Mark::O]])
    results = console_display.format_board_for_display(board)
    expect(results).to eq("X|O|X\nX|O|X\nO|X|O")
  end
end
