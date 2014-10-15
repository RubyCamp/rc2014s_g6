# encoding: UTF-8
module Control
  class Director
    def initialize
    #フォント設定
    @font = Font.new(32) 
    @font2 = Font.new(64)
    @chaser = Image.load("images/chaser.png")
    @evader = Image.load("images/evader.png")
    @speedup   = Image.load("images/speed_up.png")
    @speeddown = Image.load("images/speed_down.png")
    @timerup   = Image.load("images/time_accelerate.png")
    @timerdown = Image.load("images/time_slow.png")
    end

    def play
      Window.draw_font(0, 0, "キャラクター操作", @font2)
      Window.draw(0, 70, @evader)
      Window.draw_font(0, 110, "→　：　右移動", @font)
      Window.draw_font(0, 145, "←　：　左移動", @font)
      Window.draw_font(0, 177, "↑　：　ジャンプ", @font)
      Window.draw(330, 70 , @chaser)
      Window.draw_font(335, 110, "D　：　右移動", @font)
      Window.draw_font(335, 145, "A　：　左移動", @font)
      Window.draw_font(335, 177, "W　：　ジャンプ", @font)
      Window.draw_font(0, 235, "アイテム説明", @font2)
      Window.draw(0, 300, @speedup)
      Window.draw_font(0, 340, "スピードＵＰ", @font)
      Window.draw(330, 300 , @speeddown)
      Window.draw_font(330, 340, "スピードＤＯＷＮ", @font)
      Window.draw(0, 380, @timerup)
      Window.draw_font(0, 420, "タイマーＵＰ", @font)
      Window.draw(330, 380 , @timerdown)
      Window.draw_font(330, 420, "タイマーＤＯＷＮ", @font)
      Window.draw_font(0, 500, "SPACEでゲーム開始", @font2, {:color=>[0,255,255]})
      if Input.keyPush?(K_SPACE)
        Title::Director::Bgm.loop_count = 0
        Title::Director::Bgm.stop
        Game::Director::Bgm.play
        Scene.set_current_scene(:game)
      end
    end
  end
end
