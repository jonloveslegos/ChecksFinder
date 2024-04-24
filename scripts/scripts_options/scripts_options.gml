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
	return _hex
}

function update_options() {
	ini_open(working_directory + "game_options.ini")
	var _opt_name = "disable_periodic_updates"
	var _value = ini_read_string("preferences",_opt_name,"")
	var _tmp = false
	if (!is_string_falsy(_value)) {
		global.other_settings.auto_update = false
	}
	show_debug_message("{0} = \"{1}\" interpreted as {2}",_opt_name,_value,!global.other_settings.auto_update)
	_opt_name = "fishfinder"
	_value = ini_read_string("preferences",_opt_name,"")
	_tmp |= ini_key_exists("preferences",_opt_name)
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
	if (!is_string_falsy(_value)) {
		global.other_settings.pieces_recursive = true
	}
	show_debug_message("{0} = \"{1}\" interpreted as {2}",_opt_name,_value,global.other_settings.pieces_recursive)
	_opt_name = "tile_foreground_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.tile_data.foreground.color = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_opt_name = "tile_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.tile_data.background.color = make_color_rgb(_value[0],_value[1],_value[2])
		global.other_settings.overwrite_background = true
	}
	_opt_name = "tile_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.tile_text = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_opt_name = "ui_text_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.ui_text = make_color_rgb(_value[0],_value[1],_value[2])
		global.overwrite_tile_text = true
	}
	_opt_name = "ui_background_color"
	show_debug_message("{0}:",_opt_name)
	_value = scr_string_to_color(ini_read_string("preferences",_opt_name,""))
	if (_value != undefined) {
		global.game_color.ui_background = make_color_rgb(_value[0],_value[1],_value[2])
	}
	ini_close()
}

function is_string_falsy(_val) {
	return _val == "" || _val == "false" || _val == "f" || _val == "no" || _val == "nah" || _val == "n" || _val == "nope" || _val == "nop" || _val == "0"
}