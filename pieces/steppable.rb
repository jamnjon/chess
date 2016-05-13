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
    # if self.is_a?(King)
    #   row = @pos[0]
    #   [2,6].each do |col|
    #     moves << [row,col] if can_castle?([row,col])
    #   end
    # end
    moves
  end
  #
  # def valid_move?(start_pos, end_pos)
  #   return false unless is_valid_pos?(*end_pos) && is_valid_pos?(*start_pos)
  #
  #   delta = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
  #   directions.include?(delta) && @board[end_pos].capturable?(@color)
  #
  # end

  def is_valid_pos?(x,y)
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end
end
