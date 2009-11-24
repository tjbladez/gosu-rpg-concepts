class GameWindow < Gosu::Window
  attr_reader :map
  attr_accessor :x, :y
  def initialize
    super(640, 480, false)
    self.caption = "Adventure"
    @monsters = { :eye => []}
    @items = []
    @map = Map.new(self, 'resources/map.txt')
    self.x = self.y = 0
    spawn_player
    spawn_monsters
    spawn_items
    spawn_gui
  end


  def update
    direction = :left if button_down? Gosu::Button::KbLeft
    direction = :right if button_down? Gosu::Button::KbRight
    direction = :up if button_down? Gosu::Button::KbUp
    direction = :down if button_down? Gosu::Button::KbDown
    @player.cast_spell if button_down? Gosu::Button::KbSpace
    @player.update(direction)
    @player.collect_items!(@items)
    self.x = [[@player.x - 300, 0].max, @map.width * 50 - 640].min
    self.y = [[@player.y - 220, 0].max, @map.height * 50 - 480].min
    @monsters[:eye].each { |eye| eye.update(@player) }
  end

  def draw
    @map.draw x, y
    @player.draw x, y
    @monsters[:eye].each do |monster|
      monster.draw(x, y)
      monster.spells.each {|s| s.draw(x,y) }
    end
    @player.spells.each {|s| s.draw(x,y) }
    @items.each {|i| i.draw(x,y)}
    @player_info.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def spawn_monsters
    @monsters[:eye] << Eye.new(self, 304, 16)
    @monsters[:eye] << Eye.new(self, 340, 0)
  end
  def spawn_player
    @player = Player.new(self, 32, 32)
  end
  def spawn_items
    @items << Aid.new(self, 288, 96)
  end
  def spawn_gui
    @player_info = PlayerInfo.new(self, @player)
  end
end