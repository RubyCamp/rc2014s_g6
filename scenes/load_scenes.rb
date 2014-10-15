require_relative 'title/director'
require_relative 'game/director'
require_relative 'continue/director'
require_relative 'game_over/director'
require_relative 'control/director'
require_relative 'vod/v_evader'
require_relative 'vod/v_chaser'

Scene.add_scene(Title::Director.new,  :title)
Scene.add_scene(Game::Director.new,  :game)
Scene.add_scene(Continue::Director.new,  :continue)
Scene.add_scene(GameOver::Director.new,  :gameover)
Scene.add_scene(Control::Director.new,  :control)
Scene.add_scene(V_evader::Director.new, :v_evader)
Scene.add_scene(V_chaser::Director.new, :v_chaser)