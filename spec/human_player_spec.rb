require "human_player"
require "stringio"

RSpec.describe HumanPlayer do
  let(:human) { HumanPlayer.new(Mark::X, ConsoleDisplay.new(StringIO.new("1"), StringIO.new)) }

  it "create player with X mark" do
    expect(human.mark).to eq(Mark::X)
  end

  it "knows who it's opponent is" do
    display = ConsoleDisplay.new(StringIO.new("1"), StringIO.new)
    human_player = HumanPlayer.new(Mark::X, display)
    expect(human.get_opponent).to eq(Mark::O)
  end

  it "gets next position from console" do
    expect(human.get_next_move).to eq("1")
  end
end

