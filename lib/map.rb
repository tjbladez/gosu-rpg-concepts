require 'ruby-debug'
class Map
  attr_reader :width, :height
  attr_accessor :tiles
  KEY_TILE_MAP = {
    '.'  => 0,
    'x'  => 1,
    '-'  => 2,
    '|'  => 3,
    '/'  => 4,
    '\\' => 5,
    '<'  => 6,
    '>'  => 7 }

  def initialize(window, filename)
    @tileset = Gosu::Image.load_tiles(window, 'resources/tileset_2.png', 16, 16, true)
    self.tiles = []
    populate_tiles(filename)
  end

  def draw(screen_x, screen_y)
    @tiles.each_with_index do |row_array, y|
      row_array.each_with_index do |col, x|
        @tileset[col].draw(x * 16 - screen_x - 1, y * 16 - screen_y -1, 0)
      end
    end
  end

private
  def populate_tiles(filename)
    lines = File.readlines(filename).map{|line| line.chop }
     lines.each do |line|
       tile = []
       line.each_char do |char|
         tile << KEY_TILE_MAP[char]
       end
       tiles << tile
     end
  end

end