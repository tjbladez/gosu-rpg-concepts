require_local($root + '/lib/*.rb')

class Processor
  class << self
    attr_accessor :game_window, :menu_window
    def new
      # @menu_window = MenuWindow.new
      # @menu_window.show
     @game_window = GameWindow.new
     @game_window.show
    end

    # def start
    #   @game_window = GameWindow.new
    #   @game_window.show
    # end
    def single_player?
      true
    end
    def run

    end
  end
end