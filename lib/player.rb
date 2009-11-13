class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @x, @y = x, y
    @map = window.map
    @img = Gosu::Image.load_tiles(window, "resources/test2.png", 16,  16, false)
    @xwalking = Gosu::Image.load_tiles(window, "resources/char_right_2.png", 16, 16, false)
    @img_index = 0
    @facing = nil
  end
  def draw(x, y)
    # Flip vertically when facing to the left.
    if @facing == :right then
      offs_x = -8
      factor = 1.0
    else
      offs_x = 8
      factor = -1.0
    end
    @xwalking[@img_index].draw(@x - x + offs_x, @y - y, 0, factor, 1)
  end

  def update(direction)
    case direction
    when :left
      @img_index += 1
      5.times { @x-= 1 if would_fit?(-1, 0, 0, 0) && would_fit?(-1, 0, 0, 15) }
      @facing = :left
    when :right
      @img_index += 1
      5.times { @x+= 1  if would_fit?(1, 0, 15, 0) && would_fit?(1, 0, 15, 15) }
      @facing = :right
    when :up
      5.times { @y-= 1 if would_fit?(0, -1, 15, 0) && would_fit?(0, -1, 0, 0) }
      @facing = :up
    when :down
      5.times { @y+= 1 if would_fit?(0, 1, 15, 15) && would_fit?(0, 1, 0, 15) }
      @facing = :down
    else
      @img_index = 0
    end

    @img_index = 0 if @img_index == 4
  end

  def would_fit?(x,y, x_off, y_off)
    !@map.solid_at?(@x+ x + x_off, @y + y + y_off)
  end
end