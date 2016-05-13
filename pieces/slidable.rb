# require 'bishop'
require 'byebug'

module Slidable
  LINEAR =  [ [-1, 0],
              [ 0,-1],
              [ 1, 0],
              [ 0, 1]
                    ]

  DIAGONAL = [-1,1].product([-1,1])

  def moves
    moves = []
    directions.each do |dir|
      dx, dy = dir
      x, y = @pos
      loop do
        x, y = x + dx, y + dy
        break unless is_valid_pos?(x,y)

        if @board.empty?(x,y)
          moves << [x,y]
        else
          moves << [x,y] if  @board[[x,y]].capturable?(@color)
          break
        end
      end
    end
    moves
  end


  def is_valid_pos?(x,y)
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end

end
