require_relative 'manifest'
require_relative 'slidable'
require 'Colorize'

class Bishop < Piece
  include Slidable

  def directions
    Slidable::DIAGONAL
  end

  def initialize(color, board, pos)
    super
  end

  def to_s
    @color == :white ? ' ♝ ' : ' ♗ '
  end

end
