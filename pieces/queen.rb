require_relative 'manifest'
require_relative 'slidable'
require 'Colorize'

class Queen < Piece
  include Slidable

  def directions
    Slidable::DIAGONAL+Slidable::LINEAR
  end

  def initialize(color, board, pos)
    super
  end

  def to_s
    @color == :white ? ' ♛ ' : ' ♕ '
  end

end
