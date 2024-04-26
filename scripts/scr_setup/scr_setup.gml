function scr_setup() {
	global.fishfinder_countdown = 0
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
	global.custom_defaults = {
		tile_data: {},
		game_color: {},
	}
	var _names = struct_get_names(global.tile_data)
	for (var _i = 0; _i < array_length(_names); _i++) {
		var _orig = struct_get(global.tile_data,_names[_i])
		struct_set(global.custom_defaults.tile_data,_names[_i],{})
		var _deep_copy = struct_get(global.custom_defaults.tile_data,_names[_i])
		var __names = struct_get_names(struct_get(global.tile_data,_names[_i]))
		for (var _j = 0; _j < array_length(__names); _j++) {
			var _raw = struct_get(_orig,__names[_j])
			struct_set(_deep_copy,__names[_j],_raw)
		}
		struct_set(global.custom_defaults.tile_data,_names[_i],_deep_copy)
	}
	_names = struct_get_names(global.game_color)
	for (var _i = 0; _i < array_length(_names); _i++) {
		struct_set(global.custom_defaults.game_color,_names[_i],struct_get(global.game_color,_names[_i]))
	}
	draw_set_colour(global.game_color.ui_text);
	for (var _i = 0; _i < global.tilewidth*global.tileheight; _i++)
	{
	    global.spotlist[_i] = 0
	}
}
