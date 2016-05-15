module Steppable

  def moves
    moves = []
    directions.each do |dir|
      dx,dy = dir
      x,y = @pos
      new_x, new_y = x+dx, y+dy
      moves << [new_x, new_y] if is_valid_pos?(new_x, new_y) &&
        @board[[new_x, new_y]].capturable?(@color)
    end
    moves
  end

  def is_valid_pos?(x,y)
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end
end
