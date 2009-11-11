class Processor
  class << self
    attr_accessor :window
    def new
      @window = GameWindow.new
      @window.show
    end

    def run

    end
  end
end