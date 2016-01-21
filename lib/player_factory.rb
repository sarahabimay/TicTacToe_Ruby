class PlayerFactory
  attr_reader :players

  def initialize(display)
    @players = [HumanPlayer.new(Mark::X, display), HumanPlayer.new(Mark::O, display)]
  end

end
