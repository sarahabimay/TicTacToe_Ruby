require "tictactoe/game_type_options"

class ConsoleUI
  REQUEST_GAME_TYPE = "Please choose game type:"
  REQUEST_BOARD_DIMENSION = "Please choose board dimension: 3x3(3)."
  NEW_MOVE_REQUEST = "Please choose a position"
  PLAY_AGAIN_REQUEST = "Do you want to play a game of TIC TAC TOE? Yes(1) or No(2)?"
  WINNING_ANOUNCEMENT = "We have a winner: Player"
  DRAW_ANNOUNCEMENT = "The game is a draw!"
  OFFSET_FOR_DISPLAY = 1

  def initialize(input, output)
    @input_stream = input
    @output_stream = output
  end

  def ask_player_for_board_dimension
    output_stream.puts REQUEST_BOARD_DIMENSION
    input_stream.gets.chomp
  end

  def ask_player_for_game_type
    output_stream.puts "#{REQUEST_GAME_TYPE}\n#{TicTacToe::GameTypeOptions.for_display}";
    input_stream.gets.chomp
  end

  def ask_player_for_move(next_mark)
    output_stream.puts "#{NEW_MOVE_REQUEST} Player #{next_mark}:"  
    input_stream.gets.chomp
  end

  def ask_player_to_play_again
    output_stream.puts PLAY_AGAIN_REQUEST
    input_stream.gets.chomp
  end

  def display_board(board)
    output_stream.puts "#{format_board_for_display(board)}" 
  end

  def display_result(mark)
    !mark.nil? ? announce_winner(mark) : announce_draw
  end

  def announce_player_move(mark, move)
    output_stream.puts "Player: #{mark} has selected: #{move}"
  end

  def announce_winner(mark)
    output_stream.puts "#{WINNING_ANOUNCEMENT} #{mark}!"
  end

  def announce_draw
    output_stream.puts DRAW_ANNOUNCEMENT 
  end

  def format_board_for_display(board)
    formatted = format_board_cells(board)
    add_new_line_to_each_row(add_column_divider(formatted))
  end

  def format_board_cells(board)
    board.board_cells.flatten.collect.with_index do |cell, index|
      format_cells_for_display(cell, index)
    end
  end

  def add_column_divider(board)
    board.each_slice(3).collect { |row| row.join("|") }
  end

  def add_new_line_to_each_row(board)
    board.join("\n")
  end

  def format_cells_for_display(cell, index)
    if cell.nil?
      cell = index + OFFSET_FOR_DISPLAY
    end
    cell.to_s
  end

  private

  attr_reader :input_stream, :output_stream
end
