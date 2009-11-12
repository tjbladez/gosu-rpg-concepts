class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @x, @y = x, y
    @map = window.map
    @img = Gosu::Image.load_tiles(window, "resources/test.bmp", 16,  16, false)
    @cur_img = @img.first
  end
  def draw(x, y)
    @cur_img.draw(@x - x - 1, @y - y - 1, 1, 1)
  end
  def update(direction)
    case direction
    when :left
      5.times { @x-= 1 if would_fit?(-1, 0) }
    when :right
      5.times { @x+= 1 if would_fit?(1, 0) }
    when :up
      5.times { @y-= 1 if would_fit?(0, -1) }
    when :down
      5.times { @y+= 1 if would_fit?(0, 1) }
    else
      nil
    end
  end

  def would_fit?(x,y)
    !@map.solid?(@x + x, @y + y)
  end
end