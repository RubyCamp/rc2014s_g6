class Speedup < Sprite
  def initialize(x, y, image, director)
    super(x, y, Image.load(image))
    self.image.set_color_key([0, 0, 0])
    self.target = director.canvas
    @dy = 1
  end

  def update
    self.y += @dy
  end

  def shot(obj)
    return nil if obj.is_a?(MapChips::Blank)
    @dy = 0 if obj.is_a?(MapChips::Wall)
  end
end
