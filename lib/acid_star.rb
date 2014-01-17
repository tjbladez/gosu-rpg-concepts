require_relative 'spell'

class AcidStar < Spell
  def initialize(direction, x, y)
    super
    @image = Gosu::Image.new(Processor.game_window, 'resources/acid_star_2.png', false)
    @time_counter = 40
    @damage = 3
  end

  def draw(x,y)
    @image.draw(@x - x, @y - y, 1, 1)
    update
  end
end