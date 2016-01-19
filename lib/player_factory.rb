class PlayerFactory
  attr_reader :players

  def initialize
    @players = [HumanPlayer.new(Mark::X), HumanPlayer.new(Mark::O)]
  end

end
