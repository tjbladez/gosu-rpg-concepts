require 'ruby-debug'
class Map
  attr_reader :width, :height
  attr_accessor :tile_definitions, :tiles
  KEY_TILE_MAP = {
    '.'  => 0,
    'x'  => 1,
    '-'  => 2,
    '|'  => 3,
    '/'  => 4,
    '\\' => 5,
    '<'  => 6,
    '>'  => 7,
    '+'  => 8,
    '['  => 13,
    ']'  => 14,
    '{'  => 11,
    '}'  => 12
    }

  def initialize(window, filename)
    @tileset = Gosu::Image.load_tiles(window, 'resources/tileset_5.png', 16, 16, true)
    lines = File.readlines(filename).map{|line| line.chop }
    @width = lines[0].size
    @height = lines.size
    self.tile_definitions, self.tiles = [], []
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
        if ([13, 14].include?(col))
          @tileset[1].draw(x_position, y_position, 0)
          @tileset[col].draw(x_position, y_position, 2)
        else
          @tileset[col].draw(x_position, y_position, 0)
        end
      end
    end
  end

  def solid_at?(x,y)
    tile = tiles.detect do |tile|
      tile.x_range.include?(x) && tile.y_range.include?(y)
    end
    cross_borders?(x,y) || tile.solid?
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
        self.tiles << Tile.new(x*16, y*16, col)
      end
    end
  end
end