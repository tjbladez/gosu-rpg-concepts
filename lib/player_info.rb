class PlayerInfo
  def initialize(window, player)
    @total_hp = 20
    @total_mp = 15
    @player = player
    @font = Gosu::Font.new(window, Gosu::default_font_name, 15)
  end

  def draw
    @font.draw("Score: #{@player.score}", 5, 5, 2, 1.0, 1.0, 0xffffff00)
    @font.draw("HP: #{@player.hp} / #{@total_hp}", 540, 5, 2, 1.0, 1.0, 0xffffff00)
  end
end