require("levelgen")
require("spawndef")

meta.name = "UFO 50"
meta.version = "1.0"
meta.description = "UFO 50, it's finally here!!"
meta.author = "Super Ninja Fat"

set_callback(function()
	game_manager.screen_title.ana_right_eyeball_torch_reflection.x = 10
	game_manager.screen_title.ana_left_eyeball_torch_reflection.x = 10
	game_manager.screen_title.particle_torchflame_ash.x = 10
	game_manager.screen_title.particle_torchflame_backflames.x = 10
	game_manager.screen_title.particle_torchflame_backflames_animated.x = 10
	game_manager.screen_title.particle_torchflame_flames.x = 10
	game_manager.screen_title.particle_torchflame_flames_animated.x = 10
	game_manager.screen_title.particle_torchflame_smoke.x = 10
	game_manager.screen_title.torch_sound.playing = false
end, ON.TITLE)