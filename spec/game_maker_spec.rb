require_relative "../lib/game_maker"

class GameMakerTest
  DIMENSION_THREE = 3
  HUMAN_HUMAN_OPTION = "HVH"

  describe GameMaker do
    it "creates a game with 3x3 Board and HVH players" do
      game_maker = GameMaker.new(PlayerFactory.new(ConsoleDisplay.new($stdin, $stdout)))
      game = game_maker.create_game(DIMENSION_THREE, HUMAN_HUMAN_OPTION)
      expect(game).to be_a(Game)
    end
  end
end
