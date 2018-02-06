class Player
  attr_reader :game_over, :score, :sens
  def initialize
    @image = Gosu::Image.new("media/square.bmp")
    @vel = 16
    @sens = "right"
    @snake = [[0, 0]]
    @add = false
    @score = 0
  end

  def turn(dir)
    @sens = dir
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
      @snake.pop unless @add_square
    end
    @add_square = false
  end

  def feed(food)
    @snake.each do |x, y|
      if [food.x, food.y] == [x, y]
        food.pos_init
        @score += 1
        @add_square = true
      end
    end
  end

  def draw
    @snake.each do |x, y|
      @image.draw(x, y, 1)
    end
  end
end
