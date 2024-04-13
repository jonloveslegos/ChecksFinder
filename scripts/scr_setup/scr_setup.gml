function scr_setup() {
	global.bombcount = 5
	global.tilewidth = 5
	global.tileheight = 5
	global.checksgotten = 0
	global.spotlist = undefined
	global.tile_data = {
		foreground: {
			color: #5ac05a,
			tile_index: 0,
			piece_index: 0
		},
		background: {
			color: #aa7a50,
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
	draw_set_colour(global.game_color.ui_text);
	for (var _i = 0; _i < global.tilewidth*global.tileheight; _i++)
	{
	    global.spotlist[_i] = 0
	}
	var _file = file_find_first("*", 0);
	while (_file != "")
	{
	    if (string_count("send",_file) > 0)
	        file_delete(_file)
	    _file = file_find_next();
	}
	file_find_close();
}
