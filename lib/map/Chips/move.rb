module MapChips
  class Move < Base
    attr_accessor :right_block_limit,:left_block_limit,
                    :dx,:block_x,:block_y

    IMAGE = Image.load("images/map_move.png")
  end
end
