require 'Singleton'
class Empty_Square
  include Singleton

  def valid_move?(pos)
    false
  end

  def empty?
    true
  end

  def capturable?(color)
    true
  end

  def to_s
    "   "
  end

  def moves
    []
  end

  def color
    :none
  end
end
