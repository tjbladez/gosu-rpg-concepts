require 'ruby-debug'
class Map
  attr_reader :width, :height
  attr_accessor :tile_definitions, :solid_tiles
  SOLID_TILES = (2..8).to_a + [13, 15]

  KEY_TILE_MAP = {
    '.'  => { :index => 0, :zorder => 0 },
    'x'  => { :index => 1, :zorder => 0 },
    '-'  => { :index => 2, :zorder => 0 },
    '|'  => { :index => 3, :zorder => 0 },
    '/'  => { :index => 4, :zorder => 0 },
    '\\' => { :index => 5, :zorder => 0 },
    '<'  => { :index => 6, :zorder => 0 },
    '^'  => { :index => 16, :zorder => 1, :prereq => 1 },
    '>'  => { :index => 7, :zorder => 0 },
    '+'  => { :index => 8, :zorder => 0 },
    '['  => { :index => 13, :zorder => 0, :prereq => 1 },
    ']'  => { :index => 14, :zorder => 2, :prereq => 1 },
    '{'  => { :index => 11, :zorder => 0 },
    '}'  => { :index => 12, :zorder => 0 },
    '$'  => { :index => 15, :zorder => 1, :prereq => 1}
    }

  def initialize(window, filename)
    @tileset = Gosu::Image.load_tiles(window, 'resources/tileset_6.png', 16, 16, true)
    lines = File.readlines(filename).map{|line| line.chop }
    @width = lines[0].size
    @height = lines.size
    self.tile_definitions, self.solid_tiles = [], []
    populate_tile_definitions(lines)
    create_tiles
  end

  def draw(screen_x, screen_y)
    horizontal_range_offset = (screen_x / 16).floor
    vertical_range_offset = (screen_y / 16).floor
    horizontal_visibility_range = (0+horizontal_range_offset..41+horizontal_range_offset)
    vertical_visibility_range = (0+vertical_range_offset..31+vertical_range_offset)
    tile_definitions[vertical_visibility_range].each_with_index do |row_array, y|
      row_array[horizontal_visibility_range].each_with_index do |col, x|
        x_position = (x+horizontal_range_offset) * 16  - screen_x
        y_position = (y+vertical_range_offset) * 16 - screen_y
        @tileset[col[:prereq]].draw(x_position, y_position, 0) if col[:prereq]
        @tileset[col[:index]].draw(x_position, y_position, col[:zorder])
      end
    end
  end

  def solid_at?(x,y)
    solid_tile = solid_tiles.detect do |tile|
      tile.x_range.include?(x) && tile.y_range.include?(y)
    end
    cross_borders?(x,y) || solid_tile
  end

  def cross_borders?(x,y)
    y < 0 or x < 0
  end

private
  def populate_tile_definitions(lines)
     lines.each do |line|
       tile = []
       line.each_char do |char|
         tile << KEY_TILE_MAP[char]
       end
       tile_definitions << tile
     end
  end

  def create_tiles
    tile_definitions.each_with_index do |row_array, y|
      row_array.each_with_index do |col, x|
        self.solid_tiles << SolidTile.new(x*16, y*16) if SOLID_TILES.include?(col[:index])
      end
    end
  end
end