require 'gosu'
require_relative 'snake'

class MainGame < Gosu::Window
  def initialize
    super 400, 400
    self.caption = 'Game Ular Cari Makan'
    @background = Gosu::Image.new('./media/background.png')
    @player = Gosu::Image.new('./media/snake.png')
    @food = Gosu::Image.new('./media/food.png')
    @sfx_eat = Gosu::Sample.new('./media/eat.wav')
    @sfx_death = Gosu::Sample.new('./media/death.wav')
    @font = Gosu::Font.new(40)
    @snake = Snake.new(0, 0, 1)
    @last_moved = Time.now
    @food_x = rand(20)
    @food_y = rand(20)
    @score = 0
  end

  def draw
    @background.draw(0, 0, 0)
    @font.draw(@score, 20, 20, 2, 1.0, 1.0, Gosu::Color::YELLOW)
    @food.draw(@food_x * 20 + 1, @food_y * 20 + 1, 0)
    @snake.tails.each do |(x, y)|
      @player.draw(x * 20 + 1, y * 20 + 1, 0)
    end
  end

  def update
    return if Time.now - @last_moved < 0.15
    @snake.move
    if @snake.x == @food_x && @snake.y == @food_y
      @sfx_eat.play
      @snake.grow
      @score += 10
      @food_x = rand(20)
      @food_y = rand(20)
    end
    if @snake.hit_tails?
      @sfx_death.play
      puts 'Ouch! You hit your tail!'
      sleep 1
      close
    end
    @last_moved = Time.now
  end

  def button_down(id)
    case id
      when Gosu::KB_SPACE
        @snake.toggle_pause
      when Gosu::KB_LEFT
        @snake.turn_left
      when Gosu::KB_RIGHT
        @snake.turn_right
      when Gosu::KB_UP
        @snake.turn_up
      when Gosu::KB_DOWN
        @snake.turn_down
    end
  end
end

MainGame.new.show