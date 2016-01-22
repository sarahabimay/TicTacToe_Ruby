require "game"
require "human_player_fake"
require "pry-byebug"

RSpec.describe Game do
  DEFAULT_BOARD_SIZE = 3
  HUMAN_HUMAN_TYPE = "HVH"
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:display) { ConsoleDisplay.new(input, output) }
  let(:player1_fake) { instance_spy(HumanPlayer) }
  let(:player2_fake) { instance_spy(HumanPlayer) }
  let(:game) { Game.new(Board.new(DEFAULT_BOARD_SIZE), HUMAN_HUMAN_TYPE, [player1_fake, player2_fake]) } 

  it "game has two players" do
    expect(game.players.length).to eq(2)
  end
  
  it "keeps playing until game over" do
    expect(player1_fake).to receive(:mark).and_return(Mark::X, Mark::X, Mark::X)
    expect(player2_fake).to receive(:mark).and_return(Mark::O, Mark::O, Mark::O)
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    board = Board.new(3, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    a_game = Game.new(board, HUMAN_HUMAN_TYPE, [player1_fake, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
