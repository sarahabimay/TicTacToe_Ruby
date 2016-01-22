class ConsoleDisplay
  REQUEST_GAME_TYPE = "Please choose game type: Human vs Human(1).\n"
  REQUEST_BOARD_DIMENSION = "Please choose board dimension: 3x3(3).\n"
  NEW_MOVE_REQUEST = "Please choose a position"
  PLAYAGAIN_REQUEST = "Do you want to play a game of TIC TAC TOE? Yes(1) or No(2)?\n"
  WINNING_ANOUNCEMENT = "We have a winner:"
  DRAW_ANNOUNCEMENT = "The game is a draw!\n"

  def initialize(std_in, std_out)
    @input_stream = std_in
    @output_stream = std_out
  end

  def ask_player_for_board_dimension
    @output_stream.puts REQUEST_BOARD_DIMENSION;
    @input_stream.gets
  end

  def ask_player_for_game_type
    @output_stream.puts REQUEST_GAME_TYPE;
    @input_stream.gets
  end

  def ask_player_for_move(board)
    next_mark = board.next_mark_to_play
    @output_stream.puts "#{NEW_MOVE_REQUEST} Player #{next_mark}:\n"  
    @input_stream.gets
  end

  def ask_player_to_play_again
    @output_stream.puts PLAYAGAIN_REQUEST
    @input_stream.gets
  end

  def display_board(board)
    @output_stream.puts "#{format_board_for_display(board)}\n" 
  end

  def display_result(mark)
    if !mark.nil?
      announce_winner(mark)
    else 
      announce_draw
    end
  end

  def announce_winner(mark)
    @output_stream.puts "#{WINNING_ANOUNCEMENT} Player #{mark}!\n"
  end

  def announce_draw
    @output_stream.puts DRAW_ANNOUNCEMENT 
  end

  def format_board_for_display(board)
    formatted = board.board_cells.collect do |row|
      row.join("|")
    end
    formatted = formatted.join("\n")
  end
end
