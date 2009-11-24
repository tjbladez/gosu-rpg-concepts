class Player
  attr_reader :x, :y, :spells
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
    @img_index = 0
    @facing = :down
    @spells = []
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
    @animation_sprites[@facing][@img_index].draw(@x - x - 1, @y - y - 1 , 1, 1)
  end

  def update(direction)
    @img_index += 1
    move_instruct = @movement[direction]
    if move_instruct
      x_y = move_instruct.first
      inc_x, inc_y = *x_y
      tar_x_1, tar_y_1, tar_x_2, tar_y_2 = *move_instruct.last
      5.times do |i|
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