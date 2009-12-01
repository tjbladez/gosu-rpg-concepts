class Eye
  attr_reader :x, :y, :spells
  def initialize(window, x, y)
    @tileset = Gosu::Image.load_tiles(window, 'resources/plant_eye.png', 16, 16, false)
    @x, @y = x, y
    @spells = []
    @direction = nil
    @img_index = 1
    @casting_readiness = 0
  end

  def draw(x, y)
    @tileset[@img_index].draw(@x - x , @y - y, 1, 1)
  end

  def update(player)
    @direction = nil
    @img_index = 1
    horiz_dir(player)
    vertical_dir(player)
    if cast_ready?
      cast_spell(@direction) if @direction
      @img_index = 0 if @direction
    end
    refresh_casting
    check_spell_existance
    calculate_player_damage(player)
  end

  def calculate_player_damage(player)
    spell = @spells.detect { |s| s.hit?(player.center_x, player.center_y) }
    @spells.delete(spell)
    player.reduce_hp(spell.damage) if spell
  end

  def x_range
    (@x..@x+16)
  end

  def y_range
    (@y..@y+16)
  end

private
  def horiz_dir(player)
    return unless (y-10..y+10).include?(player.y)
    @direction = :right if x < player.x
    @direction = :left if x > player.x
  end

  def vertical_dir(player)
    return unless (x-10..x+10).include?(player.x)
    @direction = :down if y < player.y
    @direction = :up if y > player.y
  end

  def cast_spell(direction)
    star = AcidStar.new(direction, x, y)
    @spells << star
  end

  def cast_ready?
    @casting_readiness == 0
  end

  def refresh_casting
    @casting_readiness = 10 if @casting_readiness == 0
    @casting_readiness -= 1
  end

  def check_spell_existance
    @spells.reject! do |spell|
      spell.time_counter == 0
    end
  end

end