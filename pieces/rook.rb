require_relative 'manifest'
require_relative 'slidable'
require 'Colorize'

class Rook < Piece
  attr_accessor :has_moved
  include Slidable

  def directions
    Slidable::LINEAR
  end

  def initialize(color, board, pos)
    @has_moved = false
    super
  end

  def to_s
    @color == :white ? ' ♜ ' : ' ♖ '
  end

end
