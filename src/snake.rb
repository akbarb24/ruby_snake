require 'gosu'

class Snake
  attr_reader :tails
  
  def initialize(x, y, length)
    @tails = [[x, y]]
    length.times  { grow }
    @speed_x = 1
    @speed_y = 0
    @paused = false
  end

  def x
    @tails.first[0]
  end

  def y 
    @tails.first[1]
  end

  def grow
    @tails.push(@tails.last.dup)
  end

  def turn_left
    return if @speed_x == 1
    @speed_x = -1
    @speed_y = 0
  end

  def turn_right 
    return if @speed_x == -1
    @speed_x = 1
    @speed_y = 0
  end

  def turn_up
    return if @speed_y == 1
    @speed_x = 0
    @speed_y = -1
  end

  def turn_down
    return if @speed_y == -1
    @speed_x = 0
    @speed_y = 1
  end

  def move
    return if @paused
    tail = @tails.pop
    tail[0] = x + @speed_x
    tail[1] = y + @speed_y

    tail[0] %= 20
    tail[1] %= 20

    @tails.unshift(tail)
  end

  def hit_tails?
    tails_cut = @tails.slice(1, @tails.length)
    tails_cut.include?(@tails.first) && @paused == false
  end

  def paused
    @paused = true
    @paused_tails = @tails
    @paused_speed_x = @speed_x
    @paused_speed_y = @speed_y
    @speed_x = @speed_y = 0
  end

  def un_paused
    @tails = @paused_tails
    @speed_x = @paused_speed_x
    @speed_y = @paused_speed_y
    @paused = false
  end

  def toggle_pause
    if @paused
      un_paused
    else
      paused
    end
  end

end