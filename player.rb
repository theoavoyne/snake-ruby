class Player
  attr_reader :game_over, :score
  def initialize
    @image = Gosu::Image.new("media/starfighter.bmp")
    @vel = 16
    @sens = "right"
    @snake = [[0, 0]]
    @add = false
    @score = 0
  end

  def turn_left
    @sens = "left" unless @sens == "right"
  end

  def turn_right
    @sens = "right" unless @sens == "left"
  end

  def turn_up
    @sens = "up" unless @sens == "down"
  end

  def turn_down
    @sens = "down" unless @sens == "up"
  end

  def move
    base_x = @snake[0][0].to_i
    base_y = @snake[0][1].to_i
    new_pos = []
    case @sens
    when "right" then
      new_pos << (base_x + 16) % 640
      new_pos << base_y
    when "left" then
      new_pos << (base_x - 16) % 640
      new_pos << base_y
    when "up" then
      new_pos << base_x
      new_pos << (base_y - 16) % 480
    when "down" then
      new_pos << base_x
      new_pos << (base_y + 16) % 480
    end
    if @snake.include? new_pos
      @game_over = true
    else
      @snake.insert(0, new_pos)
      @snake.pop unless @add
    end
    @add = false
  end

  def feed(food)
    @snake.each do |x, y|
      if food.x == x && food.y == y
        food.x = (1...40).to_a.sample * 16
        food.y = (1...30).to_a.sample * 16
        @score += 1
        @add = true
      end
    end
  end

  def draw
    @snake.each do |x, y|
      @image.draw(x, y, 1)
    end
  end
end
