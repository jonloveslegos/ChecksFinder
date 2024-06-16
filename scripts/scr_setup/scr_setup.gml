function scr_setup() {
	global.fishfinder_countdown = 0
	global.layout_update_required = false
	global.debug_view = false
	global.bombcount = 5
	global.tilewidth = 5
	global.tileheight = 5
	global.spotlist = array_create(25,int64(0))
	global.before_game = true
	global.last_payload = []
	global.item_list = []
	global.save_file = game_save_id + "save_file.ini"
	layer_background_blend(layer_background_get_id(layer_get_id("Colour_main")), global.game_color.ui_background)
}
