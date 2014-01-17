require_relative 'map'

class GameWindow < Gosu::Window
  attr_reader :map
  attr_accessor :x, :y
  def initialize
    super(640, 480, false)
    self.caption = "Adventure"
    @monsters = { :eye => []}
    @map = Map.new(self, 'resources/map.txt')
    self.x = self.y = 0
    draw
    @player = @map.actors['Player'].first
    initialize_music
  end


  def update
    direction = :left if button_down? Gosu::Button::KbLeft
    direction = :right if button_down? Gosu::Button::KbRight
    direction = :up if button_down? Gosu::Button::KbUp
    direction = :down if button_down? Gosu::Button::KbDown
    @player.cast_spell if button_down?(Gosu::Button::KbSpace) && @player.cast_ready?
    @player.update(direction)
    items = @map.actors['Aid']
    monsters = @map.actors['Eye']
    @player.collect_items!(items)
    monsters.each { |monster| monster.update(@player) }

    self.x = [[@player.x - 300, 0].max, @map.width * 50 - 640].min
    self.y = [[@player.y - 220, 0].max, @map.height * 50 - 480].min
  end

  def draw
    @map.draw x, y
    @map.actors.values.each do |actor_set|
      actor_set.each do |actor|
        actor.draw x,y
        actor.spells.each {|s| s.draw(x,y)} if actor.respond_to?(:spells)
        actor.info.draw(x, y) if actor.respond_to?(:info)
      end
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

private

  def initialize_music
    Gosu::Song.new(self, 'resources/music/battle.mp3').play(true)
  end
end