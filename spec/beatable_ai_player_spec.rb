require "beatable_ai_player"

RSpec.describe BeatableAIPlayer do
  let(:display_spy) { instance_spy(ConsoleUI) }
  let(:beatable_player) { BeatableAIPlayer.new(Mark::X, display_spy) }

  it "knows who it's opponent is" do
    expect(beatable_player.get_opponent_mark).to eq(Mark::O)
  end

  it "gets next position from console" do
    expect(beatable_player.get_next_move).to be_between(1, 9).inclusive 
  end

  it "displays new move to console" do
    expect(display_spy).to receive(:announce_player_move)
    beatable_player.get_next_move
  end
end

