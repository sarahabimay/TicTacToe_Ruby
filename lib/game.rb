class Game
  attr_reader :players, :game_type

  def initialize(board, game_type, board_displayer, players)
    @board = board
    @game_type = game_type
    @board_displayer = board_displayer
    @players = players
  end

  def get_winning_mark
    @board.get_winning_mark
  end

  def find_player_by_mark(mark)
    return players[mark] if players.has_key?(mark)
  end

  def play_turns
    while !@board.is_game_over? do
      begin
        play_next_move
        display_board 
      rescue ArgumentError  => error
        p "#{error.class} and #{error.message}"
      end
    end
    @board
  end

  def play_next_move
    next_player = find_player_by_mark(@board.next_mark_to_play)
    @board = @board.play_mark_in_position(@board.next_mark_to_play, next_player.get_next_move)
  end

  def display_board
    board_displayer.display_board(@board)
  end

  private
  attr_reader :board_displayer, :board
end
