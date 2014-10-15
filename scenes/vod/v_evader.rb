# encoding:UTF-8
module V_evader
  class Director
    def initialize
      @bgm_win = Sound.new("music/chaser_win.wav")
      @bgm_play = 1
      #フォント設定
      @font = Font.new(32)
      @font2 = Font.new(64)
    end

    def play
      #文字表示
      if @bgm_play == 1
        @bgm_win.play
        @bgm_play = 0
      end
      Window.draw_font(270, 200, "逃げ切った!!", @font2)
      Window.draw_font(300, 350, "逃走者の勝ち", @font)

      if Input.keyPush?(K_SPACE)
        @bgm_play = 1
        Scene.set_current_scene(:continue)
      end
    end
  end
end
