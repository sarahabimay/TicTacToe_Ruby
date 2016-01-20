class Game
  attr_reader :players, :game_type

  def initialize(board, game_type, players)
    @board = board
    @game_type = game_type
    @players = create_player_list(players)
  end

  def create_player_list(players)
    @players = Hash[players.collect { |player| [player.mark, player] } ] 
  end

  def find_player_by_mark(mark)
    return @players[mark] if @players.has_key?(mark)
  end

  def play_turns
    while !@board.is_game_over? do
      next_player = find_player_by_mark(@board.next_mark_to_play)
      next_position = next_player.get_next_position
      @board = @board.play_mark_in_position(next_player.mark, next_position)
    end
    @board
  end
end
