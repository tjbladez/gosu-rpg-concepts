class GameWindow < Gosu::Window
  attr_reader :map
  attr_accessor :x, :y
  def initialize
    super(800, 600, false)
    self.caption = "Adventure"
    self.x = self.y = 0
  end


  def update
  end

  def draw
  end
end