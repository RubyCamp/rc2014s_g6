class Timerdown <Sprite
  def initialize(x, y, image, director)
    @director  = director
    super(x, y, Image.load(image))
    self.image.set_color_key([0, 0, 0])
    self.target = director.canvas
    @dx = 0
    @dy = 0
  end

  def update
    self.y += @dy
  end

  def hit(obj)
    @director.timer.limit_time  -= 5
  end
end
