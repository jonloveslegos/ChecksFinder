function scr_ap_load_data() {
	var _filename = file_find_first(game_save_id + "*.item",0)
	var _layout_update = false
	while (_filename != "")
	{
	    if (!file_exists(_filename+"obtain"))
	    {
	        var _file = file_text_open_read(_filename)
	        var _read = file_text_read_string(_file)
	        if (real(string_digits(_read)) == 80000) {
				_layout_update = true
	            scr_get_item("width")
			}
	        if (real(string_digits(_read)) == 80001) {
				_layout_update = true
	            scr_get_item("height")
			}
	        if (real(string_digits(_read)) == 80002) {
	            scr_get_item("bomb")
			}
	        file_text_close(_file)
	        file_text_close(file_text_open_write(_filename+"obtain"))
	    }
	    _filename = file_find_next()
	}
	return _layout_update
}

function scr_ap_update_checks() {
	for (var _i = 0; _i < array_length(global.spotlist);_i++) {
		if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5) {
			if (!file_exists(game_save_id+"send"+string(_i+81000))) {
				global.spotlist[_i] = 0
			} else {
				global.spotlist[_i] = 1
			}
		}
	}
}
