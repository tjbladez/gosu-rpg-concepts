class Spell
  attr_reader :x, :y, :time_counter, :damage
  def initialize(direction, x, y)
    @movements = {
      :down => [0, 7],
      :right => [7, 0],
      :left => [-7, 0],
      :up => [0, -7]
    }
    @direction = direction
    @x, @y = x, y
  end

  def update
    x_inc, y_inc = *@movements[@direction]
    @x += x_inc
    @y += y_inc
    @time_counter -= 1
  end

  def hit?(t_x, t_y)
    x_range = t_x-6..t_x+6
    y_range = t_y-6..t_y+6
    x_range.include?(center_x) && y_range.include?(center_y)
  end

  def center_x
    @x + 8
  end

  def center_y
    @y + 8
  end

  def center
    [center_x, center_y]
  end
end