require "Colorize"
require_relative "cursorable"
require_relative 'pieces/manifest'
##Thanks to rglassett on github for this code!
class Display
  include Cursorable

  def initialize(board, game)
    @board = board
    @cursor_pos = [7, 4]
    @game = game
    @selected_pos = nil
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if (i + j).odd?
      bg = :black
    else
      bg = :light_black
    end
    current_piece = @board[@cursor_pos]
    if @selected_pos
      current_piece = @board[@selected_pos]
    end
    if current_piece.color == @game.current_color
      current_piece.moves.each do |pos|
        if [i,j] == pos
          bg = :blue
        end
      end
      if current_piece.is_a?(King)
        if current_piece.can_castle?([7,6]) && (@cursor_pos == [7,4] || @selected_pos == [7,4])
          if [i,j] == [7,6]
            bg = :blue
          end
        end
        if current_piece.can_castle?([7,2]) && (@cursor_pos == [7,4] || @selected_pos == [7,4])
          if [i,j] == [7,2]
            bg = :blue
          end
        end
        if current_piece.can_castle?([0,6]) && (@cursor_pos == [0,4] || @selected_pos == [0,4])
          if [i,j] == [0,6]
            bg = :blue
          end
        end
        if current_piece.can_castle?([0,2]) && (@cursor_pos == [0,4] || @selected_pos == [0,4])
          if [i,j] == [0,2]
            bg = :blue
          end
        end
      end
    end
    if [i,j] == @selected_pos
      bg = :magenta
    end

    if [i, j] == @cursor_pos
      bg = :red
    end
    { background: bg, color: :white}
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    if @selected_pos
      puts @game.current_player.name + ", where do you want to move it?"
    else
      puts @game.current_player.name + ", select a " + @game.current_color.to_s + " piece to move"
    end
    if @board.in_check?(@game.current_player.color)
      puts "CHECK!"
    end
    # puts @board[@cursor_pos].moves
    # puts @board[@cursor_pos].is_a?(King) && @board[@cursor_pos].can_castle?([7,6])
    # puts @selected_pos
  end
end
