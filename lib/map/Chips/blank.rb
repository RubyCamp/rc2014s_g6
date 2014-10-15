module MapChips
  class Blank < Base
    attr_accessor :appear

    IMAGE = Image.load("images/map_blank.png")

    def initialize(x, y, director)
      super
      @appear = false
    end
  end
end
