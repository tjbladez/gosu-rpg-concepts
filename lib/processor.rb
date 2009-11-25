class Processor
  class << self
    attr_accessor :game_window
    def new
      @game_window = GameWindow.new
      @game_window.show
    end

    def single_player?
      true
    end
    def run

    end
  end
end