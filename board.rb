require_relative "pieces/manifest"
require 'byebug'

class Board

  def initialize (grid = nil, is_new = true)
    if grid.nil?
      @grid ||= Array.new(8){Array.new(8){Empty_Square.instance}}
      populate if is_new
    else
      @grid = grid
    end
  end

  def empty?(x,y)
    @grid[x][y].empty?
  end

  def color(pos)
    self[pos].color
  end

  def move(start_pos, end_pos)

    if self[start_pos].valid_move?(end_pos)

      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = Empty_Square.instance

      if self[end_pos].is_a?(King) || self[end_pos].is_a?(Rook)
        self[end_pos].has_moved = true
      end

      if self[end_pos].is_a?(King)
        row = start_pos[0]
        dy = end_pos[1] - start_pos[1]
        if dy == 2
          move!([row, 7], [row, 5])
        elsif dy == -2
          move!([row, 0], [row, 3])
        end
      end

      if self[end_pos].is_a?(Pawn) && [0,7].include?(end_pos[0])
        return :promote
      end
    else
      puts "Invalid Move."
      raise ArgumentError.new("Invalid Move. Try again!")
    end
    nil
  end

  def piece_spawn(piece_type, pos, color)
    case piece_type
      when 'Q'
        self[pos] = Queen.new(color, self, pos)
      when 'R'
        self[pos] = Rook.new(color, self, pos)
      when 'B'
        self[pos] = Bishop.new(color, self, pos)
      when 'N'
        self[pos] = Knight.new(color, self, pos)
      end
  end

  def inspect
    render
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x,y = pos
    @grid[x][y] = mark
  end

  def populate
    @grid[0] = get_pieces(:black, 0)
    @grid[1] = get_pawns(:black, 1)
    @grid[7] = get_pieces(:white, 7)
    @grid[6] = get_pawns(:white, 6)
  end

  def get_pieces(color, row)
    [Rook.new(color, self,[row,0]),
     Knight.new(color, self, [row,1]),
     Bishop.new(color, self, [row,2]),
     Queen.new(color, self, [row,3]),
     King.new(color, self, [row, 4]),
     Bishop.new(color, self, [row,5]),
     Knight.new(color, self, [row,6]),
     Rook.new(color, self,[row,7])
    ]
  end

  def get_pawns(color, row)
    arr = Array.new(8)
    arr.map.with_index {|el, idx| Pawn.new(color, self, [row, idx])}
  end

  def get_empty_squares
    Array.new(8){Empty_Square.instance}
  end

  def render
    puts "  #{(0..7).to_a.join(' ')}"
    @grid.each_with_index do |row, ind|
      puts "#{ind} #{row.join(' ')}"
    end
  end

  def in_bounds?(x,y)
    is_valid_pos?(x,y)
  end

  def is_valid_pos?(x,y)
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end

  def pieces
    pieces = []
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        pieces << @grid[i][j] if @grid[i][j].is_a?(Piece)
      end
    end
    pieces
  end

  def find_king_pos(color)
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        return [i,j] if @grid[i][j].is_a?(King) && @grid[i][j].color == color
      end
    end
    raise RuntimeError.new("no king found")
  end

  def in_check?(color)
    king_pos = find_king_pos(color)
    enemy_pieces = pieces.select{|piece| piece.color != color}
    enemy_pieces.each do |piece|
      return true if piece.moves.include?(king_pos)
    end
    false
  end

  def in_checkmate?(color)
    return false unless in_check?(color)
    friend_pieces = pieces.select{|piece| piece.color == color}
    friend_pieces.all?{|piece| piece.valid_moves.empty?}
  end

  def dup
    new_board = Board.new(nil, false)
    pieces.each do |piece|
      new_board[piece.pos] = piece.class.new(piece.color, new_board, piece.pos)
    end
    new_board
  end


  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = Empty_Square.instance
  end

  def rows
    @grid
  end
end

if __FILE__ == $PROGRAM_NAME
end
