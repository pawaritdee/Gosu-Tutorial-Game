require 'gosu'

class MyGame < Gosu::Window
  def initialize
    super(640, 480)  # Width and height of the window
    self.caption = "Tutorial Gosu Game"
  # Player
    @player_image = Gosu::Image.new('player.png')
    @player_x = 300  # Initial player position
    @player_y = 400    
  # Object
    @object_image = Gosu::Image.new('object.png')
    @object_x = rand(640)  # Initial coin position
    @object_y = 0
  # Background
    @background_image = Gosu::Image.new('background.jpg')
  # Initial Score
    @score = 0       # Initial Score  
    @font = Gosu::Font.new(24)  # Font for displaying the score
    @game_over = false  # Initialize the game over state

  end

  def update
    if @game_over == false
      if Gosu.button_down?(Gosu::KB_LEFT) && @player_x > 0
        @player_x -= 5  # Move left
      end

      if Gosu.button_down?(Gosu::KB_RIGHT) && @player_x < 640 - @player_image.width
        @player_x += 5  # Move right
      end

      @object_y += 5  # Move the coin down
      if @object_y > 480
        @object_x = rand(640)
        @object_y = 0
      end

      if collision?(@player_x, @player_y, @object_x, @object_y)
        @object_x = rand(640)
        @object_y = 0
        @score += 1  # Increase the score on collection
      end
    end
     # Check the "Game Over" condition
     if @score >= 10
      @game_over = true
    end
  end


  def draw
    @background_image.draw(0, 0, 0)
    @player_image.draw(@player_x, @player_y, 0)
    @object_image.draw(@object_x, @object_y, 0)

    @font.draw_text("Score: #{@score}", 10, 10, 0)

    if @game_over
      @font.draw_text("YOU WIN!", 200, 220, 0, 2.0, 2.0, Gosu::Color::RED)
    end
  end
end

def collision?(x1, y1, x2, y2)
  # Simple collision detection, checks if two rectangles overlap
  (x1 < x2 + @object_image.width) && (x1 + @player_image.width > x2) &&
  (y1 < y2 + @object_image.height) && (y1 + @player_image.height > y2)
end

window = MyGame.new
window.show
