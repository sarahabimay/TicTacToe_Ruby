require 'enumerator'
require "mark"

class Board 
  attr_reader :board_size

  X_POSITION_2D = 0
  Y_POSITION_2D = 1
  ZERO_INDEX_OFFSET = 1
  LOWER_INDEX_LIMIT = 1

  def initialize(dimension, board_cells = [])
    @dimension = dimension 
    @board_size = @dimension * @dimension
    @board = create_board_cells(board_cells)
  end

  def create_board_cells(board_cells)
    if !board_cells.nil? && board_cells.flatten.length > 0
      board_cells
    else
      position = 0
      Array.new(@dimension) { Array.new(@dimension) { position += ZERO_INDEX_OFFSET; position.to_s } }
    end
  end

  def play_mark_in_position(mark, position_key)
    raise ArgumentError, "Invalid Board Position" if !valid_position?(position_key)
    raise ArgumentError, "Position Already Taken" if position_occupied?(position_key)
    flattened = @board.flatten
    flattened[position_key] = mark
    @board = flattened.each_slice(@dimension).to_a
  end

  def valid_position?(position_key)
    return false if position_key.to_i < LOWER_INDEX_LIMIT
    return false if position_key.to_i > @board_size
    true
  end

  def position_occupied?(position_key)
    Mark.is_a_mark?(find_mark_in_position(position_key))
  end

  def find_mark_in_position(position_key)
    flattened = @board.flatten
    flattened[position_key]
  end

  def next_mark_to_play
    return Mark::X if number_of_positions_for_mark(Mark::X) < number_of_positions_for_mark(Mark::O)
    Mark::O
  end

  def number_of_positions_for_mark(mark)
    flat_board = @board.flatten
    flat_board.find_all { |x| x == mark }.size
  end
  def is_game_over?()
    found_win_in_columns || found_win_in_rows || found_win_in_diagonals
  end

  def found_win_in_columns
    find_column_win_for_mark(Mark::X) || find_column_win_for_mark(Mark::O)
  end
  
  def find_column_win_for_mark(mark)
    find_row_win_for_mark(mark, @board.transpose)
  end

  def found_win_in_rows
    find_row_win_for_mark(Mark::X, @board) || find_row_win_for_mark(Mark::O, @board)
  end

  def find_row_win_for_mark(mark, board)
    board.collect{ |row| row.all? { |a_mark| a_mark == mark } }.any? { |result| result == true }
  end

  def found_win_in_diagonals
    find_diagonal_win_for_mark(Mark::X) || find_diagonal_win_for_mark(Mark::O)
  end

  def find_diagonal_win_for_mark(mark)
    diagonal_coordinates = get_diagonal_coordinates
    result = diagonal_coordinates.collect do |group| 
      group.all? do |coords| 
        @board[coords[X_POSITION_2D]][coords[Y_POSITION_2D]] == mark 
      end
    end
    result.any? { |found| found == true }
  end

  def get_diagonal_coordinates
    coordinates = Array.new
    @dimension.times do |i|
      coordinates << [i,i]
    end
    @dimension.times do |i|
      coordinates << [i, zero_indexed_dimension - i]
    end
    coordinates.each_slice(@dimension).to_a
  end

  def zero_indexed_dimension
    @dimension - ZERO_INDEX_OFFSET 
  end
end
