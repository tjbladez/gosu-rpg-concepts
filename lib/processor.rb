require_local($root + '/lib/*.rb')

class Processor
  class << self
    attr_accessor :game_window
    def new
     @game_window = GameWindow.new
     @game_window.show
    end
  end
end