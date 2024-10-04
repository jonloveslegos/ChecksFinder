function scr_setup_options(){
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
		ui_background: c_green,
		textbox_text: c_white,
		textbox_background: #2a662a,
		input_text: #c0c0c0,
		button_text: c_yellow,
		button_background: #804000,
	}
	global.other_settings = {
		auto_update: true,
		pieces_count: 4,
		pieces_recursive: true,
		enable_fishfinder: false,
		overwrite_tile_text: false,
		overwrite_background: false,
	}
	scr_update_options()
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
}

function scr_update_options() {
	ini_open(working_directory + "game_options.ini")
	var _opt_name = "fishfinder"
	var _value = ini_read_string("preferences",_opt_name,"")
	var _tmp = ini_key_exists("preferences",_opt_name)
	show_debug_message("{0} = \"{1}\"",_opt_name,_value)
	if (_value == "") {
		_opt_name = "fishing"
		_value = ini_read_string("preferences",_opt_name,"")
		_tmp |= ini_key_exists("preferences",_opt_name)
		show_debug_message("{0} = \"{1}\"",_opt_name,_value)
	}
	if (_value == "") {
		_opt_name = "fisher"
		_value = ini_read_string("preferences",_opt_name,"")
		_tmp |= ini_key_exists("preferences",_opt_name)
		show_debug_message("{0} = \"{1}\"",_opt_name,_value)
	}
	if (_value == "") {
		_opt_name = "fish"
		_value = ini_read_string("preferences",_opt_name,"")
		_tmp |= ini_key_exists("preferences",_opt_name)
		show_debug_message("{0} = \"{1}\"",_opt_name,_value)
	}
	global.other_settings.enable_fishfinder = !is_string_falsy(_value)
	show_debug_message("interpreted whether to enable fishing as {0}",global.other_settings.enable_fishfinder)
	//if state of fishfinder was overwritten, don't enable the april fools joke
	if (!_tmp && (current_month == 4 && current_day == 1)) {
		global.other_settings.enable_fishfinder = true
		show_debug_message("April Fools!")
	}
	_opt_name = "falling_pieces_count"
	_value = floor(ini_read_real("preferences",_opt_name,-1))
	show_debug_message("{0} = \"{1}\", interpreted as {2}",_opt_name,ini_read_string("preferences","pieces_count",""),_value)
	if (_value >= 0 && _value <= 4) {
		global.other_settings.pieces_count = _value
		show_debug_message("setting {0} to \"{1}\"",_opt_name,_value)
	} else {
		show_debug_message("{0} is outside the valid range of 0 to 4, keeping at default {1}",_opt_name,global.other_settings.pieces_count)
	}
	_opt_name = "falling_pieces_recursive"
	_value = ini_read_string("preferences",_opt_name,"")
	if (is_string_falsy(_value)) {
		global.other_settings.pieces_recursive = false
	}
	show_debug_message("{0} = \"{1}\" interpreted as {2}",_opt_name,_value,global.other_settings.pieces_recursive)
	_opt_name = "tile_foreground_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.tile_data.foreground.color = _value
	}
	_opt_name = "tile_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.tile_data.background.color = _value
		global.other_settings.overwrite_background = true
	}
	_opt_name = "tile_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.tile_text = _value
	}
	_opt_name = "ui_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.ui_text = _value
		global.other_settings.overwrite_tile_text = true
	}
	_opt_name = "ui_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.ui_background = _value
	}
	_opt_name = "textbox_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.textbox_text = _value
	}
	_opt_name = "textbox_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.textbox_background = _value
	}
	_opt_name = "input_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.input_text = _value
	}
	_opt_name = "button_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.button_text = _value
	}
	_opt_name = "button_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.button_background = _value
	}
	ini_close()
}

function scr_string_to_color(_str) {
	var _len = string_length(_str)
	if (_len != 6 && _len != 3) {
		show_debug_message("Color \"{0}\" is not length 6 or 3",_str)
		return undefined
	}
	if (_len > string_length(string_lettersdigits(_str))) {
		show_debug_message("Color \"{0}\" has not alphanumeric characters",_str)
		return undefined
	}
	_str = string_upper(_str)
	var _hex = array_create(3)
	for (var _i = 0; _i < _len; _i++) {
		var _digit = string_char_at(_str, _i + 1)
		if (ord(_digit) > ord("F") && ord(_digit) <= ord("Z")) {
			show_debug_message("In color \"{0}\" encountered a char \"{1}\", which is not a hex digit", _str, _digit)
			return undefined
		} else {
			
		}
		if (_len == 3) {
			_hex[_i] = "0x" + _digit + _digit
		} else {
			var _ii = _i div 2
			if (_i % 2 == 0) {
				_hex[_ii] = "0x" + _digit
			} else {
				_hex[_ii] += _digit
			}
		}
	}
	//apparently "0xgarbage" is a valid hex number
	_hex[0] = real(_hex[0]) //red
	_hex[1] = real(_hex[1]) //green
	_hex[2] = real(_hex[2]) //blue
	return make_color_rgb(_hex[0],_hex[1],_hex[2])
}

function is_string_falsy(_val) {
	return _val == "" || _val == "false" || _val == "f" || _val == "no" || _val == "nah" || _val == "n" || _val == "nope" || _val == "nop" || _val == "0"
}