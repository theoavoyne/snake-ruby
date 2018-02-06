class Tutorial < Gosu::Window
  def initialize
    super 640, 480, false, 60
    self.caption = "Snake"
    @player = Player.new
    @food = Food.new
    @font = Gosu::Font.new(20)
  end

  def update
    if @player.game_over
    elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.turn_left
    elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.turn_right
    elsif Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP
      @player.turn_up
    elsif Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN
      @player.turn_down
    end
    @player.move
    @player.feed(@food)
  end

  def draw
    @player.draw
    @food.draw
    @font.draw("Score: #{@player.score}", 10, 10, 0)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end
