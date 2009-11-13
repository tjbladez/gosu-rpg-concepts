class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @x, @y = x, y
    @map = window.map
    @img = Gosu::Image.load_tiles(window, "resources/test2.png", 16,  16, false)
    @cur_img = @img.first
    @facing = nil
  end
  def draw(x, y)
    @cur_img.draw(@x - x - 1, @y - y - 1, 1, 1)
  end
  def update(direction)
    case direction
    when :left
      5.times { @x-= 1 if would_fit?(-1, 0, 0, 0) && would_fit?(-1, 0, 0, 15) }
      @facing = :left
    when :right
      5.times { @x+= 1  if would_fit?(1, 0, 15, 0) && would_fit?(1, 0, 15, 15) }
      @facing = :right
    when :up
      5.times { @y-= 1 if would_fit?(0, -1, 15, 0) && would_fit?(0, -1, 0, 0) }
      @facing = :up
    when :down
      5.times { @y+= 1 if would_fit?(0, 1, 15, 15) && would_fit?(0, 1, 0, 15) }
      @facing = :down
    else
      nil
    end
  end

  def would_fit?(x,y, x_off, y_off)
    !@map.solid_at?(@x+ x + x_off, @y + y + y_off)
  end
end