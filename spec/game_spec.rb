require "game"
require "human_player_fake"
require "console_ui"

RSpec.describe Game do
  let(:console_ui_spy) { instance_spy(ConsoleUI) }
  let(:player1_fake) { instance_spy(HumanPlayer) }
  let(:player2_fake) { instance_spy(HumanPlayer) }

  it "game has two players" do
    game = Game.new(Board.new(BoardOptions::THREE_BY_THREE), GameTypeOptions::HVH, console_ui_spy, [player1_fake, player2_fake]) 
    expect(game.players.length).to eq(2)
  end
  
  it "keeps playing until game over" do
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    a_game = Game.new(board, GameTypeOptions::HVH, console_ui_spy, Hash[Mark::X, player1_fake, Mark::O, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end

  it "displays board to UI via board displayer" do
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    expect(console_ui_spy).to receive(:display_board)
    board = Board.new(BoardOptions::THREE_BY_THREE, [[Mark::X, Mark::X, Mark::O], [Mark::O, Mark::X, 6], [7, 8, 9]])
    a_game = Game.new(board, GameTypeOptions::HVH, console_ui_spy, Hash[Mark::X, player1_fake, Mark::O, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
