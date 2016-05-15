require_relative 'board'
require_relative 'human_player'
require_relative 'Display'
class Game
  attr_reader :current_player, :current_color
  def initialize(board = Board.new, player1 = HumanPlayer.new("Player 1", :white), player2 = HumanPlayer.new("Player 2", :black))
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
    @current_color = @current_player.color
    @display = Display.new(@board, self)
  end

  def play
    until @board.in_checkmate?(@current_color)
      @display.render
      begin
        start_pos = get_user_input
        raise RuntimeError if @board.color(start_pos) != @current_color
        end_pos = get_user_input
        resp = @board.move(start_pos, end_pos)
        if resp
          piece_type = get_piece_type
          @board.piece_spawn(piece_type, end_pos, @current_color)
        end
      rescue
        retry
      end
      player_swap!
    end
    player_swap!
    @display.render
    puts "Congratulations #{@current_player.name}, you won!"
  end

  def get_piece_type
    type = nil
    pieces = ['Q','R','B','N']
    until pieces.include?(type)
      puts "What type of piece do you want? (Q,R,B,N)"
      type = gets.chomp.upcase
    end
    type
  end

  def player_swap!
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    @current_color = @current_player.color
  end

  def get_user_input
    input = @display.get_input
    until input
      input = @display.get_input
    end
    input
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
