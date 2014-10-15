module Game
  class Director
    attr_reader :map, :canvas,:timer
    Bgm = Sound.new("music/game.wav")
    Bgm.loop_count = -1
    def initialize
      @canvas = RenderTarget.new(800, 600)
      @offset_x = 0
      @offset_y = 0
      @bg_img = Image.load("images/background_game.png")
      @map = Map.new("map_data/stage1.dat", self)
      @ev = Evader.new(200, 500, "images/evader.png", self)
      @ch = Chaser.new(600, 500, "images/chaser.png", self)
      @chars = [@ev, @ch]
      @items = []
      3.times{ @items << Speedup.new(rand(700) + 50 , rand(500), "images/speed_up.png", self)}
      2.times{@items << Timerup.new(rand(700) + 50, rand(500), "images/time_accelerate.png", self)}
      3.times{ @items << Speeddown.new(rand(700) + 50, rand(500), "images/speed_down.png", self)}
      2.times{@items << Timerdown.new(rand(700) + 50, rand(500), "images/time_slow.png", self)}
      @timer = Disptimer.new
      @item_i = 0
    end

    def play
      Window.draw(0, 0, @bg_img)
      @map.draw
      Sprite.draw(@chars)
      Sprite.draw(@items)
      Window.draw(@offset_x, @offset_y, @canvas)
      if @timer.start_time.nil? || @timer.sec < 0
        initialize
        @timer.set_start_time
      end
      @timer.count_down
      @timer.draw
     
			@map.move
      Sprite.update(@chars)
      end_checker = Sprite.check(@chars)
      if end_checker
        initialize
        Scene.set_current_scene(:v_chaser)
      end
      Sprite.check(@chars, @map.draw_items)
      Sprite.update(@items)
      Sprite.check(@chars, @items)
      Sprite.check(@items, @map.draw_items)
      item_plus
    end

    def item_plus
    	@item_i +=1
    	if(@item_i % 200 ==0)
    		case rand(4)
    		when 0
    			@items << Speedup.new(rand(700) + 50 , rand(500), "images/speed_up.png", self)
    		when 1
    			@items << Timerup.new(rand(700) + 50, rand(500), "images/time_accelerate.png", self)
    		when 2
    			@items << Speeddown.new(rand(700) + 50, rand(500), "images/speed_down.png", self)
    		when 3
    			@items << Timerdown.new(rand(700) + 50, rand(500), "images/time_slow.png", self)
    		end
    		@item_i = 0
    	end
    end
  end
end
