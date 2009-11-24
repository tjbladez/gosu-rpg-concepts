class Aid
  attr_reader :x, :y, :effect_amount
  def initialize(window, x, y)
    @img = Gosu::Image.new(window, 'resources/aid_1.png', true)
    @x, @y = x, y
    @effect_amount = 5
  end

  def draw(x,y)
    @img.draw_rot(@x - x, @y - y, 1, 25*Math.sin(Gosu::milliseconds / 133.7))
  end

  def effect_method
    :restore_hp
  end

end