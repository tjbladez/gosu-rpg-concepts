class Fireball
 attr_reader :x, :y
 def initialize(direction, x, y)
   @tileset = Gosu::Image.load_tiles(Processor.game_window, 'resources/fireball.png', 16, 16, false)
   @sprites = {
     :down => @tileset.first(2),
     :right => @tileset[2..3],
     :left => @tileset[4..5],
     :up => @tileset.last(2)
     }
   @movements = {
     :down => [0, 2],
     :right => [2, 0],
     :left => [-2, 0],
     :up => [0, -2]
   }
   @direction = direction
   @x, @y = x, y
 end

 def draw
   @sprites[@direction][rand(2)].draw(@x, @y, 1, 1)
   update
 end

 def update
   x_inc, y_inc = *@movements[@direction]
   @x, @y = @x + x_inc, @y + y_inc
 end
end