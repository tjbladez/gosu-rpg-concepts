class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @x, @y = x, y
    @map = window.map
    right = Gosu::Image.load_tiles(window, "resources/char_right_2.png", 16, 16, false)
    down = Gosu::Image.load_tiles(window, "resources/char_down_1.png", 16, 16, false)
    left = Gosu::Image.load_tiles(window, "resources/char_left_1.png", 16, 16, false)
    @animation_sprites = {:left  => left,
                          :down  => down,
                          :up    => down,
                          :right => right}
    @img_index = 0
    @facing = :down
  end
  def draw(x, y)
    @animation_sprites[@facing][@img_index].draw(@x - x - 1, @y - y - 1 , 1, 1)
  end

  def update(direction)
    @img_index += 1
    case direction
    when :left
      5.times { @x-= 1 if would_fit?(-1, 0, 0, 0) && would_fit?(-1, 0, 0, 14) }
      @facing = :left
    when :right
      5.times { @x+= 1  if would_fit?(1, 0, 14, 0) && would_fit?(1, 0, 14, 14) }
      @facing = :right
    when :up
      5.times { @y-= 1 if would_fit?(0, -1, 14, 0) && would_fit?(0, -1, 0, 0) }
      @facing = :up
    when :down
      5.times { @y+= 1 if would_fit?(0, 1, 14, 14) && would_fit?(0, 1, 0, 14) }
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