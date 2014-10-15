class Chaser < Sprite
  MARGIN = 2
  def initialize(x, y, image, director)
    super(x, y, Image.load(image))
    self.collision = [4, 4, 28 ,28]
    self.image.set_color_key([0, 0, 0])
    self.target = director.canvas
    @dx = 2
    @dy = 3
    @item_effect = 0
    @jump = false
    @jump_height_rest = 0
    @jump_height_once = 15
  end

  def update
    @old_x = self.x
    @old_y = self.y
    @hit_flag = false
    if Input.key_down?(K_D)
      @dx = 2 + @item_effect
      self.x += @dx
      if self.x > Window.width
        self.x = -self.image.width
      end
    end
    if Input.key_down?(K_A)
      @dx = -2 - @item_effect
      self.x += @dx
      if self.x < -self.image.width
        self.x = Window.width
      end
    end
    if Input.key_push?(K_W)
      if @jump == false
        @jump_height_rest = 200
        @jump = true
      end
    end
    if Input.key_down?(K_S)
      self.y += 1
    end
    self.y += @dy
    self.y = -self.image.height if self.y > Window.height
    jump
  end

  def col_left_x
    self.x + self.collision[0]
  end

  def col_right_x
    self.x + self.collision[2]
  end

  def col_up_y
    self.y + self.collision[1]
  end

  def col_down_y
    self.y + self.collision[3]
  end

  def hit(obj)
    self.x += -@dx
  end

  def shot(obj)
    if obj.is_a?(MapChips::Wall) && @hit_flag == false
      if obj.x + obj.image.width > col_left_x
        if obj.y + MARGIN < col_down_y
          delta_x = @dx.abs + 1
          self.x += delta_x * (@dx < 0 ? 1 : -1)
        end
      end
      if col_up_y > obj.y
        @jump_height_rest = 0
        self.y = @old_y
      end
      self.y = @old_y
      @jump = false
      @hit_flag = true
      return nil
    end
    if obj.is_a?(MapChips::Move) && @hit_flag == false
      if obj.x + obj.image.width > col_left_x
        if obj.y + MARGIN < col_down_y
          delta_x = @dx.abs + 1
          self.x += delta_x * (@dx < 0 ? 1 : -1)
        end
      end
      if col_up_y > obj.y
        @jump_height_rest = 0
        self.y = @old_y
      end
      self.y = @old_y
      @jump = false
      @hit_flag = true
      return nil
    end
    if obj.is_a?(MapChips::Appear) && @hit_flag == false
      if obj.x + obj.image.width > col_left_x
        if obj.y + MARGIN < col_down_y
          delta_x = @dx.abs + 1
          self.x += delta_x * (@dx < 0 ? 1 : -1)
        end
      end
      if col_up_y > obj.y
        @jump_height_rest = 0
        self.y = @old_y
      end
      self.y = @old_y
      @jump = false
      @hit_flag = true
      return nil
    end
    get_item?(obj)
  end

  def get_item?(obj)
    if obj.is_a?(Speedup)
      @item_effect += 0.3
      obj.vanish
    elsif obj.is_a?(Speeddown)
      @item_effect -= 0.3
      obj.vanish
    else
    end
    obj.vanish if obj.is_a?(Timerup)
    obj.vanish if obj.is_a?(Timerdown)
  end

def jump
    if @jump_height_rest > 0
      self.y -= @jump_height_once
      @jump_height_rest -= @jump_height_once
    end
    if @jump_height_rest <= 0
      @jump_height_rest = 0
    end
  end
end
