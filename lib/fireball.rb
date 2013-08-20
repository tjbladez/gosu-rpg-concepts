require_relative 'spell'

class Fireball < Spell
 def initialize(direction, x, y)
   super
   @tileset = Gosu::Image.load_tiles(Processor.game_window, 'resources/fireball.png', 16, 16, false)
   @sprites = {
     :down => @tileset.first(2),
     :right => @tileset[2..3],
     :left => @tileset[4..5],
     :up => @tileset.last(2)
     }
   @time_counter = 30
 end

 def draw(x,y)
   @sprites[@direction][rand(2)].draw(@x - x, @y - y, 1, 1)
   update
 end

end