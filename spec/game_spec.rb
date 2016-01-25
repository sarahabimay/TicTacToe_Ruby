require "game"
require "human_player_fake"
require "console_board_displayer"

require "pry-byebug"

RSpec.describe Game do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:display) { ConsoleDisplay.new(input, output) }
  let(:board_displayer_spy) { instance_spy(ConsoleBoardDisplayer) }
  let(:player1_fake) { instance_spy(HumanPlayer) }
  let(:player2_fake) { instance_spy(HumanPlayer) }
  let(:game) { Game.new(Board.new(BoardOptions::THREE_BY_THREE), GameType::HVH, board_displayer_spy, [player1_fake, player2_fake]) } 

  it "game has two players" do
    expect(game.players.length).to eq(2)
  end
  
  it "keeps playing until game over" do
    expect(player1_fake).to receive(:mark).and_return(Mark::X, Mark::X, Mark::X)
    expect(player2_fake).to receive(:mark).and_return(Mark::O, Mark::O, Mark::O)
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    a_game = Game.new(board, GameType::HVH, board_displayer_spy, [player1_fake, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end

  it "displays board to UI via board displayer" do
    expect(player1_fake).to receive(:mark).and_return(Mark::X, Mark::X, Mark::X)
    expect(player2_fake).to receive(:mark).and_return(Mark::O, Mark::O, Mark::O)
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    expect(board_displayer_spy).to receive(:display_board)
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    a_game = Game.new(board, GameType::HVH, board_displayer_spy, [player1_fake, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
