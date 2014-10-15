module GameOver
  class Director
    def initialize
      @bg_img = Image.load("images/end.png")
    end

    def play
      Window.draw(0, 0, @bg_img)
      exit if Input.keyPush?(K_SPACE)
    end
  end
end
