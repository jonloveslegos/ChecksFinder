function scr_setup() {
	global.fishfinder_countdown = 0
	global.debug_view = false
	global.bombcount = 5
	global.tilewidth = 5
	global.tileheight = 5
	global.spotlist = array_create(5,undefined)
	layer_background_blend(layer_background_get_id(layer_get_id("Colour_main")), global.game_color.ui_background)
	for (var _i = 0; _i < global.tilewidth*global.tileheight; _i++)
	{
	    global.spotlist[_i] = 0
	}
}
