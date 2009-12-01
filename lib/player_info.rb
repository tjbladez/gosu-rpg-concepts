class PlayerInfo
  def initialize(window, player)
    @player = player
    @font = Gosu::Font.new(window, Gosu::default_font_name, 15)
  end

  def draw(x, y)
    level = @player.level
    @font.draw("Score: #{@player.score}", 5, 5, 2, 1.0, 1.0, 0xffffff00)
    @font.draw("HP: #{@player.hp} / #{@player.total_hp[level]}", 540, 5, 2, 1.0, 1.0, 0xffffff00)
    @font.draw("MP: #{@player.mp} / #{@player.total_mp[level]}", 540, 20, 2, 1.0, 1.0, 0xffffff00)
  end
end