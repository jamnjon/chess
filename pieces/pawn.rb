require_relative 'manifest'
require_relative 'slidable'
require 'Colorize'
require 'byebug'



class Pawn < Piece

  def initialize(color, board, pos)
    super
  end

  def directions
    if @color == :white
      moves = [[-1,0], [-1,-1], [-1,1]]
      moves << [-2,0] if @pos[0] == 6
    else
      moves = [[1,0], [1,-1], [1,1]]
      moves << [2,0] if @pos[0] == 1
    end
    moves
  end

  def moves
    moves = []
    directions.each do |dir|
      x, y = @pos
      dx, dy = dir
      x, y = x + dx, y + dy
      next unless is_valid_pos?(x,y)
      if dy == 0
        next unless @board[[x,y]].empty?
        if dx == 2
          next unless @board[[pos[0] + 1, pos[1]]].empty?
        elsif dx == -2
          next unless @board[[pos[0] -1, pos[1]]].empty?
        end
        moves << [x,y]
      else
        moves << [x,y] if !@board[[x,y]].empty? && @board[[x,y]].capturable?(@color)
      end
    end
    moves
  end

  def is_valid_pos?(x,y)
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end



  def to_s
    @color == :white ? ' ♟ ' : ' ♙ '
  end

end
