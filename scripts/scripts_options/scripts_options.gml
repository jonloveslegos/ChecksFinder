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
			show_debug_message("In color \"{0}\" encountered \"{1}\", which is not a hex digit", _str, _digit)
			return undefined
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

function update_settings() {
	ini_open(working_directory + "game_options.ini")
	var _value = scr_string_to_color(ini_read_string("preferences","tile_foreground_color",""))
	if (_value != undefined) {
		global.tile_data.foreground.color = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_value = scr_string_to_color(ini_read_string("preferences","tile_background_color",""))
	if (_value != undefined) {
		global.tile_data.background.color = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_value = scr_string_to_color(ini_read_string("preferences","tile_text_color",""))
	if (_value != undefined) {
		global.game_color.tile_text = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_value = scr_string_to_color(ini_read_string("preferences","ui_text_color",""))
	if (_value != undefined) {
		global.game_color.ui_text = make_color_rgb(_value[0],_value[1],_value[2])
	}
	_value = scr_string_to_color(ini_read_string("preferences","ui_background_color",""))
	if (_value != undefined) {
		global.game_color.ui_background = make_color_rgb(_value[0],_value[1],_value[2])
	}
	ini_close()
}
