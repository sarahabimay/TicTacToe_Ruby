require "human_player"
require "stringio"

RSpec.describe HumanPlayer do
  let(:input) { StringIO.new("1") }
  let(:output) { StringIO.new }
  let(:display) { ConsoleDisplay.new(input, output) }
  let(:human) { HumanPlayer.new(Mark::X, display) }
  let(:board) { Board.new(3) }

  it "create player with X mark" do
    expect(human.mark).to eq(Mark::X)
  end

  it "knows who it's opponent is" do
    human_player = HumanPlayer.new(Mark::X, display)
    expect(human.get_opponent).to eq(Mark::O)
  end

  it "gets next position from console" do
    expect(human.get_next_move).to eq("1")
  end
end

