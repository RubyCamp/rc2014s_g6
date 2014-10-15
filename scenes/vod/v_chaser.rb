# encoding: UTF-8
module V_chaser
  class Director
    def initialize
      @bgm_lose = Sound.new("music/game_over.wav")
      @bgm_play = 1
      #フォント設定
      @font = Font.new(32)
      @font2 = Font.new(64)
    end

    def play
    #文字表示
      if @bgm_play == 1
        @bgm_lose.play
        @bgm_play = 0
      end
      Window.draw_font(270, 200, "捕まえた!!", @font2)
      Window.draw_font(300, 350, "鬼の勝ち", @font)
      if Input.keyPush?(K_SPACE)
        @bgm_play = 1
        Scene.set_current_scene(:continue)
      end
    end
  end
end
