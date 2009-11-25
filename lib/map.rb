require 'lib/player'
require 'lib/aid'
require 'lib/eye'
require 'ruby-debug'
class Map
  attr_reader :width, :height, :actors
  attr_accessor :tile_definitions, :solid_tiles
  SOLID_TILES = (2..8).to_a + [13, 15]

  def initialize(window, filename)
    @tileset = Gosu::Image.load_tiles(window, 'resources/tileset_6.png', 16, 16, true)
    lines = File.readlines(filename).map{|line| line.chop }
    @width = lines[0].size
    @height = lines.size
    @actors = {}
    @window = window
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
        y_position = (y+vertical_range_offset) * 16 - screen_y-
        zorder = col[:zorder] || 0
        if col[:actor]
          @actors[col[:actor].to_s] ||= []
          @actors[col[:actor].to_s] << col.delete(:actor).new(@window, x_position, y_position)
        end
        @tileset[col[:prereq]].draw(x_position, y_position, 0) if col[:prereq]
        @tileset[col[:index]].draw(x_position, y_position, zorder)
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
         tile << key_tile_map[char]
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

  def key_tile_map
    {
      '.'  => { :index => 0},
      'x'  => { :index => 1 },
      '-'  => { :index => 2 },
      '|'  => { :index => 3 },
      '/'  => { :index => 4 },
      '\\' => { :index => 5 },
      '<'  => { :index => 6 },
      '^'  => { :index => 16, :zorder => 1, :prereq => 1 },
      '>'  => { :index => 7 },
      '+'  => { :index => 8 },
      '['  => { :index => 13, :prereq => 1 },
      ']'  => { :index => 14, :zorder => 2, :prereq => 1 },
      '{'  => { :index => 11 },
      '}'  => { :index => 12 },
      '$'  => { :index => 15, :zorder => 1, :prereq => 1},
      'p'  => { :actor => Player, :index => 0 },
      'a'  => { :actor => Aid, :index => 1 },
      'e'  => { :actor => Eye, :index => 0}
      }
  end
end