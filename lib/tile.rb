class Tile
  attr_reader :type
  attr_accessor :x, :y, :x_range, :y_range
  SOLID_TILES = (2..8).to_a

  def initialize(x, y, type)
    self.x, self.y = x, y
    @type = type
    self.x_range = (x..x+16)
    self.y_range = (y..y+16)
  end

  def solid?
    SOLID_TILES.include?(@type)
  end

end