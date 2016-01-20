require_relative "../lib/command_line_ui"
require "rspec"

class CommandLineUITest
  DIMENSION_THREE = 3
  HUMAN_HUMAN_GAME = "HVH"
  describe CommandLineUI do
    let(:display) { ConsoleDisplay.new($stdin, $stdout) }
    let(:command_line) { CommandLineUI.new(GameMaker.new(PlayerFactory.new(display)), display) }
    it "initialize a 3x3, HVH game" do
      command_line.create_new_game_from_options(DIMENSION_THREE, HUMAN_HUMAN_GAME)
      expect(command_line.game_type).to eq("HVH")
    end

    it "sets up the game and plays" do
      command_line.create_new_game_from_options(DIMENSION_THREE, HUMAN_HUMAN_GAME)
    end

    it "asks user if they want to replay" do

    end
  end
end
