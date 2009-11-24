class Player
  attr_reader :x, :y, :spells, :score, :hp, :mp, :exp
  def initialize(window, x, y)
    @x, @y = x, y
    @map = window.map
    right = Gosu::Image.load_tiles(window, "resources/char_right_2.png", 16, 16, false)
    down = Gosu::Image.load_tiles(window, "resources/char_down_1.png", 16, 16, false)
    left = Gosu::Image.load_tiles(window, "resources/char_left_1.png", 16, 16, false)
    up = Gosu::Image.load_tiles(window, "resources/char_up_1.png", 16, 16, false)
    @animation_sprites = {:left  => left,
                          :down  => down,
                          :up    => up,
                          :right => right}
    @img_index, @score = 0, 0
    @facing = :down
    @spells = []
    @hp, @mp = 20, 15
    @exp = 0
    @exp_req = { 1 => 1000, 2 => 2500, 3 => 5000, 4 => 11500}

    @movement = {
      :left  => [[-1, 0],[0, 0, 0, 14]],
      :right => [[1, 0], [14, 0, 14, 14]],
      :up    => [[0, -1],[14, 0, 0, 0]],
      :down  => [[0, 1], [14, 14, 0, 14]]
    }
  end
  def cast_spell
    fireball = Fireball.new(@facing, @x, @y)
    @spells << fireball
  end
  def draw(x, y)
    @animation_sprites[@facing][@img_index].draw(@x - x, @y - y, 1, 1)
  end

  def update(direction)
    @img_index += 1
    move_instruct = @movement[direction]
    if move_instruct
      x_y = move_instruct.first
      inc_x, inc_y = *x_y
      tar_x_1, tar_y_1, tar_x_2, tar_y_2 = *move_instruct.last
      4.times do |i|
        if would_fit?(x_y + [tar_x_1, tar_y_1]) && would_fit?(x_y + [tar_x_2, tar_y_2])
          @x += inc_x
          @y += inc_y
          @facing = direction
        end
      end
    else
      @img_index = 0
    end
    @img_index = 0 if @img_index == 4
    check_spell_existance
  end

  def collect_items!(items)
    item = items.detect do |item|
      (item.x - @x).abs < 10 and (item.y - @y).abs < 10
    end
    self.send(item.effect_method, item.effect_amount) && items.delete(item) if item
  end

  def reduce_hp(amount)
    @hp -= amount
  end

  def restore_hp(amount)
    @hp += amount
  end
  def center
    [center_x, center_y]
  end

  def center_x
    @x + 8
  end

  def center_y
    @y + 8
  end
private
  def would_fit?(target)
    !@map.solid_at?(@x+ target[0] + target[2], @y + target[1] + target[3])
  end
  def check_spell_existance
    @spells.reject! do |spell|
      spell.time_counter == 0
    end
  end
end