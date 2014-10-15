module MapChips
  class Base < Sprite
    attr_accessor :map_x, :map_y

    def initialize(x, y, director)
      super(x, y, self.class::IMAGE)
      @director = director
      self.target = @director.canvas
    end
  end
end
