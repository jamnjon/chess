require 'Colorize'
require 'byebug'
require_relative 'manifest'
class Piece
  attr_accessor :pos, :color

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    false
  end

  def capturable?(color)
    @color != color
  end

  def to_s
    "p".green
  end

  def valid_move?(end_pos)
    (moves.include?(end_pos) && !move_into_check?(end_pos)) ||
      (is_a?(King) && can_castle?(end_pos))
  end

  def valid_moves
    moves.reject{|move| move_into_check?(move)}
  end

  def move_into_check?(move)
    test_board = @board.dup
    # debugger
    test_board.move!(@pos, move)
    test_board.in_check?(@color)
  end
end
