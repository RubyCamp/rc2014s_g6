class Map
  CHIP_W = 32
  CHIP_H = 32
  attr_accessor :draw_items

  def initialize(dat_file_path, director)
    @director = director
    @chips = []
    @chips << MapChips::Blank
    @chips << MapChips::Wall
    @chips << MapChips::Move
    @chips << MapChips::MoveBlank1
    @chips << MapChips::MoveBlank2
    @chips << MapChips::Appear
    @map = []

    @move_left_ary=[0,1,2,13,14,15,6,7,8,9]
    @move_right_ary=[10,11,12,22,23,24,16,17,18,19]
    @move_dx_ary=[1,1,1,-1,-1,-1,1,1,1,1]
    @move_i=0
    @move_set=0
    @draw_items = []
    @mspeed = 0   
    @mb_left_x = 4  
    @mb_right_x = 21  
    @move_a = 0
    @pspeed = 0
    @pit
    @pitfall = @chips[0].new(nil, nil, @director)
    File.open(dat_file_path) do |f|
      f.each do |line|
        @map << line.chomp.split(/\s*,\s*/).map{|i| 
          chip = @chips[i.to_i].new(nil, nil, director)
          if (i == "2")
            chip.right_block_limit = @move_right_ary[@move_set]
            chip.left_block_limit = @move_left_ary[@move_set]
            chip.dx = @move_dx_ary[@move_set]
            @move_set += 1
          end
          chip
        }
      end
    end
  end

  def get_pos(x, y)
    return @map[y][x]
  end


  def draw
    @draw_items = []
    map_x(0).upto(map_x(@director.canvas.width)) do |m_x|
      map_y(0).upto(map_y(@director.canvas.height)) do |m_y|
        next unless @map[m_y]
        chip = @map[m_y][m_x]
        next unless chip
        chip.map_x = m_x
        chip.map_y = m_y
        x = m_x * CHIP_W 
        y = m_y * CHIP_H
        chip.x = x
        chip.y = y
        @draw_items << chip
      end
    end
    Sprite.draw(@draw_items)
  end

  def conv_map_pos(x, y)
    return [map_x(x), map_y(y)]
  end

  def move
    move_all_chips_with_wait
    move_b
    move_appear
    move_pit
  end

  def move_appear
    @move_a += 1
    if(@move_a % 100 == 0)
      appear_block_exchange_blank
      @move_a = 0
    end
  end

  def move_all_chips_with_wait
    @move_i += 1
    if(@move_i % 7 == 0)
      move_all_chips
      @move_i = 0
    end
  end

  def move_b
    @mspeed += 1
    if(@mspeed % 30 == 0)
      move_blank_1
      move_blank_2
      @mspeed = 0
    end
  end

  def move_pit
		@pspeed += 1
    if(@pspeed % 20 == 0)
      pitfall
      @pspeed = 0
    end
  end

  def move_blank_1
    map_x(0).upto(map_x(@director.canvas.width)) do |m_x|
      map_y(0).upto(map_y(@director.canvas.height)) do |m_y|
        next unless @map[m_y]
        chip = @map[m_y][m_x]
        next unless chip

        if chip.is_a?(MapChips::MoveBlank1)
          if @map[m_y][m_x + 1].is_a?(MapChips::Wall)
            tmp = @map[m_y][m_x + 1]
            @map[m_y][m_x + 1] = chip
            @map[m_y][m_x] = tmp
            return
          elsif @map[m_y][m_x + 1].is_a?(MapChips::Blank)
            tmp = @map[m_y][@mb_left_x]
            @map[m_y][@mb_left_x] = chip
            @map[m_y][m_x] = tmp
            return
          end
        end
      end
    end
  end

  def move_blank_2
    map_x(0).upto(map_x(@director.canvas.width)) do |m_x|
      map_y(0).upto(map_y(@director.canvas.height)) do |m_y|
        next unless @map[m_y]
        chip = @map[m_y][m_x]
        next unless chip
        if chip.is_a?(MapChips::MoveBlank2)
          if @map[m_y][m_x - 1].is_a?(MapChips::Wall)
            tmp = @map[m_y][m_x - 1]
            @map[m_y][m_x - 1] =chip
            @map[m_y][m_x] = tmp
            return
          elsif @map[m_y][m_x - 1].is_a?(MapChips::Blank)
            tmp = @map[m_y][@mb_right_x]
            @map[m_y][@mb_right_x] = chip
            @map[m_y][m_x] = tmp
            return
          end
        end
      end
    end
  end

  def pitfall
    ex_pit = @pit
    @pit = rand(20) + 2
    @map[18][@pit] = @pitfall
    if(ex_pit)
      @map[18][ex_pit] = @chips[1].new(nil,nil,@director)
    end
  end

  private
  def map_x(x)
    return x.to_i / CHIP_W
  end

  def map_y(y)
    return y.to_i / CHIP_H
  end

  def offset_px_x(x)
    return x.to_i % CHIP_W
  end

  def offset_px_y(y)
    return y.to_i % CHIP_H
  end

  def move_all_chips
    move_chips_right =[]
    move_chips_left =[]
    0.upto(map_y(@director.canvas.height)) do |m_y|
      0.upto(map_x(@director.canvas.width)) do |m_x|
        next unless @map[m_y]
        chip = @map[m_y][m_x]
        next unless chip
        if(chip.is_a?(MapChips::Move))
          chip.block_x = m_x
          chip.block_y = m_y
          move_chips_right << chip if(chip.dx==1)
          move_chips_left << chip if(chip.dx==-1)
        end
      end
    end
    move_chips_right.reverse_each do |chip|
      move_chip(chip,chip.block_x,chip.block_y)
    end
    move_chips_left.each do |chip|
      move_chip(chip,chip.block_x,chip.block_y)
    end
  end

  def move_chip(chip,m_x,m_y)
    obj_chip = @map[m_y][m_x + chip.dx]
    @map[m_y][m_x + chip.dx] = chip
    @map[m_y][m_x] = obj_chip
    chip.block_x = m_x + chip.dx
    chip.block_y = m_y
    if((chip.dx == 1 &&chip.block_x == chip.right_block_limit)||(chip.dx == -1 && chip.block_x == chip.left_block_limit))
      chip.dx *= -1
    end
  end

  def appear_block_exchange_blank
    0.upto(map_y(@director.canvas.height)) do |m_y|
      0.upto(map_x(@director.canvas.width)) do |m_x|
        next unless @map[m_y]
        chip = @map[m_y][m_x]
        next unless chip
        if(chip.is_a?(MapChips::Appear))
          @map[m_y][m_x] = @chips[0].new(nil, nil, @director)
          @map[m_y][m_x].appear = true
          next
        end
        if(chip.is_a?(MapChips::Blank) && chip.appear)
          @map[m_y][m_x].appear = false
          @map[m_y][m_x] = @chips[5].new(nil, nil, @director)
        end
      end
    end
  end
end
