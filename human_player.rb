class HumanPlayer
  attr_reader :color, :name
  def initialize(name = "", color = :black)
    @name = name
    @color = color
  end
end
