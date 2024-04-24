function scr_setup() {
	global.debug_view = false
	global.bombcount = 5
	global.tilewidth = 5
	global.tileheight = 5
	global.spotlist = array_create(5,undefined)
	global.tile_data = {
		foreground: {
			color: #2a662a,
			tile_index: 0,
			piece_index: 0
		},
		background: {
			color: #66442a,
			tile_index: 0,
			piece_index: 0
		},
		bomb: {
			color: c_white,
			tile_index: 1,
			piece_index: 2
		},
	}
	global.game_color = {
		tile_text: c_red,
		ui_text: c_white,
		ui_background: c_green
	}
	global.other_settings = {
		auto_update: true,
		pieces_count: 4,
		pieces_recursive: true,
		enable_fishfinder: false,
		overwrite_tile_text: false,
		overwrite_background: false,
	}
	update_options()
	draw_set_colour(global.game_color.ui_text);
	for (var _i = 0; _i < global.tilewidth*global.tileheight; _i++)
	{
	    global.spotlist[_i] = 0
	}
	var _file = file_find_first(game_save_id + "*", 0);
	while (_file != "")
	{
	    if (string_count("send",_file) > 0)
	        file_delete(game_save_id + _file)
	    _file = file_find_next();
	}
	file_find_close();
}
