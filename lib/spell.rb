class Spell
 attr_reader :x, :y, :time_counter
 def initialize(direction, x, y)
   @movements = {
     :down => [0, 10],
     :right => [10, 0],
     :left => [-10, 0],
     :up => [0, -10]
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
end