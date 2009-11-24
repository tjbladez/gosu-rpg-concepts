class Eye
 attr_reader :x, :y, :spells
 def initialize(window, x, y)
   @img = Gosu::Image.new(window, 'resources/plant_eye.png', false)
   @x, @y = x, y
   @spells = []
   @direction = nil
 end

 def draw(x, y)
   @img.draw(@x - x , @y - y, 1, 1)
 end

 def update(player)
   @direction = nil
   horiz_dir(player)
   vertical_dir(player)
   cast_spell(@direction) if @direction
   check_spell_existance
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

 def check_spell_existance
   @spells.reject! do |spell|
     spell.time_counter == 0
   end
 end
end