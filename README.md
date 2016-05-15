# Chess

Chess is a 2-human-player ruby game to be run in terminal.  It utilizes a tweaked version of cursorable by rglassett on github for keyboard control. The board is a grid made by a 2-dimensional array (8x8).

![gameplay](https://github.com/jamnjon/chess/blob/master/chess.png)

## Implementation

Each of the pieces uses either the `slidable` or `steppable` module to populate their potential moves.  The `Empty_Square` is a singleton that has no possible moves. At the start of the game, the board is populated with the appropriate pieces in their appropriate places. At the beginning of the turn, we check if the player is in checkmate. As the player moves the cursor, it shows each available move for each piece, and once he or she selects a piece it shows just the available moves for that piece as he or she moves the cursor.  The game has all typical chess functionality (castling, pawn promotion).

Moves list for any of the `steppable` pieces (`King`, `Knight`)
````ruby
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
````
