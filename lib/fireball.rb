class Fireball
 attr_reader :x, :y, :time_counter
 def initialize(direction, x, y)
   @tileset = Gosu::Image.load_tiles(Processor.game_window, 'resources/fireball.png', 16, 16, false)
   @sprites = {
     :down => @tileset.first(2),
     :right => @tileset[2..3],
     :left => @tileset[4..5],
     :up => @tileset.last(2)
     }
   @movements = {
     :down => [0, 7],
     :right => [7, 0],
     :left => [-7, 0],
     :up => [0, -7]
   }
   @direction = direction
   @x, @y = x, y
   @time_counter = 30
 end

 def draw(x,y)
   @sprites[@direction][rand(2)].draw(@x - x, @y - y, 1, 1)
   update
 end

 def update
   x_inc, y_inc = *@movements[@direction]
   @x += x_inc
   @y += y_inc
   @time_counter -= 1
 end
end