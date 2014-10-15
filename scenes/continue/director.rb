module Continue
  class Director
    def initialize
      #フォント設定
      @font = Font.new(32)
      @font2 = Font.new(64)
    end
    def play
      #文字表示
      Window.draw_font(270, 200, "Continue", @font2)
      Window.draw_font(300, 350, "YES", @font)
      Window.draw_font(430, 350, "NO", @font)
      #マウス決定  YES        
      if 297 <= Input.mousePosX && Input.mousePosX <= 355 
        if 353 <= Input.mousePosY && Input.mousePosY < 378
          Scene.set_current_scene(:control) if Input.mousePush?(M_LBUTTON)
        end
      end
      #マウス決定  NO     
      if 430 <= Input.mousePosX && Input.mousePosX <= 473
        if 353 <= Input.mousePosY && Input.mousePosY < 378
          Scene.set_current_scene(:gameover) if Input.mousePush?(M_LBUTTON)
        end
      end
    end
  end
end
