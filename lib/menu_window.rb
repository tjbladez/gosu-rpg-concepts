class MenuWindow < Gosu::Window

  def initialize
    super(640, 480, false)
    self.caption = "Adventure Game Menu"
    @image = Gosu::Image.new(self, "resources/main_menu.png", true)
    @song = Gosu::Song.new(self, 'resources/music/menu.mp3')
    @song.play(true)
  end
  def draw
    @image.draw(0, 0, 0)
  end
  def update
  end
end
