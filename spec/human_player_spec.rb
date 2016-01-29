require "human_player"
require "stringio"

RSpec.describe HumanPlayer do
  let(:display_spy) { instance_spy(ConsoleUI) }
  let(:human) { HumanPlayer.new(Mark::X, display_spy) }

  it "knows who it's opponent is" do
    expect(human.get_opponent_mark).to eq(Mark::O)
  end

  it "gets next position from console" do
    expect(display_spy).to receive(:ask_player_for_move).and_return("1")
    expect(human.get_next_move).to eq("1")
  end
end

