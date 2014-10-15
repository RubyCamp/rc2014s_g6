module Title
  class Director
  Bgm = Sound.new("music/op.wav")
  Bgm.loop_count = -1
    def initialize
      #フォント設定
      @font = Font.new(32)
      @font2 = Font.new(64)
    end

    def play
    #文字表示
      Window.drawFontEx(260, 200, "Oni Gokko", @font2, :shadow=>true,  :shadow_edge=>true, :shadow_color=>[255,0,0],  :shadow_x=>3,  :shadow_y=>3)
      Window.draw_font(350, 300, "START", @font)
    #キー決定
      Scene.set_current_scene(:control) if Input.keyPush?(K_SPACE)

    #マウス決定
      if 340 <= Input.mousePosX && Input.mousePosX <= 445 
        if 300 <= Input.mousePosY && Input.mousePosY < 330
          Scene.set_current_scene(:control) if Input.mousePush?(M_LBUTTON)
        end
      end
    end
  end
end
