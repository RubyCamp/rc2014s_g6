module Title
  class Director
  Bgm = Sound.new("music/op.wav")
  Bgm.loop_count = -1
    def initialize
      #�t�H���g�ݒ�
      @font = Font.new(32)
      @font2 = Font.new(64)
    end

    def play
    #�����\��
      Window.drawFontEx(260, 200, "Oni Gokko", @font2, :shadow=>true,  :shadow_edge=>true, :shadow_color=>[255,0,0],  :shadow_x=>3,  :shadow_y=>3)
      Window.draw_font(350, 300, "START", @font)
    #�L�[����
      Scene.set_current_scene(:control) if Input.keyPush?(K_SPACE)

    #�}�E�X����
      if 340 <= Input.mousePosX && Input.mousePosX <= 445 
        if 300 <= Input.mousePosY && Input.mousePosY < 330
          Scene.set_current_scene(:control) if Input.mousePush?(M_LBUTTON)
        end
      end
    end
  end
end
