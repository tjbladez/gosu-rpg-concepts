class Map
  attr_reader :width, :height

  def initialize(window, filename)
    @tileset = Gosu::Image.load_tiles(window, 'resources/tileset_2.png', 16, 16, true)
    lines = File.readlines(filename).map{|line| line.chop }
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x,1]
        when '.'
          0
        when 'x'
          1
        when '-'
          2
        when '|'
          3
        when '/'
          4
        when '\\'
          5
        when '<'
          6
        when '>'
          7
        else
          0
        end
      end
    end
  end

  def draw(screen_x, screen_y)
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        if tile
          # Draw the tile with an offset (tile Gosu::Images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * 16 - screen_x - 1, y * 16 - screen_y - 1, 0)
        end
      end
    end
  end


end