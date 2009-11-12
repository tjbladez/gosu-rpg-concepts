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
    lines = File.readlines(filename).map{|line| line.chop }
    @width = lines[0].size
    @height = lines.size
    self.tiles = []
    populate_tiles(lines)
  end

  def draw(screen_x, screen_y)
    horizontal_range_offset = (screen_x / 16).floor
    vertical_range_offset = (screen_y / 16).floor
    horizontal_visibility_range = (0+horizontal_range_offset..41+horizontal_range_offset)
    vertical_visibility_range = (0+vertical_range_offset..31+vertical_range_offset)
    tiles[vertical_visibility_range].each_with_index do |row_array, y|
      row_array[horizontal_visibility_range].each_with_index do |col, x|
        x_position = (x+horizontal_range_offset) * 16  - screen_x - 1
        y_position = (y+vertical_range_offset) * 16 - screen_y -1
        @tileset[col].draw(x_position, y_position, 0)
      end
    end
  end

  def solid?(x,y)
    puts "x #{x}, y #{y} "
    cross_borders?(x,y)
  end

  def cross_borders?(x,y)
    y < 0 or x < 0
  end

private
  def populate_tiles(lines)
     lines.each do |line|
       tile = []
       line.each_char do |char|
         tile << KEY_TILE_MAP[char]
       end
       tiles << tile
     end
  end

end