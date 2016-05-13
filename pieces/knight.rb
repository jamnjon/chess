require_relative 'manifest'
require_relative 'steppable'
require 'Colorize'

class Knight < Piece
  include Steppable

  def directions
    [[1,2], [2,1], [1,-2], [-2,1], [-1,2], [2,-1], [-1,-2],[-2,-1]]
  end

  def initialize(color, board, pos)
    super
  end

  def to_s
    @color == :white ? ' ♞ ' : ' ♘ '
  end

end
