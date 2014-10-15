class Disptimer
  attr_accessor :start_time, :sec, :limit_time
  
  def initialize
    @font = Font.new(32)
    @limit_time = 30 + 1
  end

  def set_start_time
    @start_time = Time.now
  end

  def count_down
    @now_time = Time.new
    @diff_time = @now_time - @start_time
    @countdown = (@limit_time - @diff_time).to_i
    @sec = @countdown
  end

  def draw
    Window.drawFont(400,0,"#{@sec}",@font)

    if @sec <=10
      Window.drawFont(400,0,"#{@sec}",@font,{:color=>[255,0,0]})
    end

    if @sec == 0
      Scene.set_current_scene(:v_evader)
    end
  end
end
