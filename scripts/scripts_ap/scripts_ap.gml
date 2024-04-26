function scr_ap_load_data() {
	var _layout_update = false
	return global.roomthisbomb != global.bombcount || global.roomthisheight != global.tileheight || global.roomthiswidth != global.tilewidth
}

function scr_ap_update_checks() {
	for (var _i = 0; _i < array_length(global.spotlist);_i++) {
		if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5) {
			if (array_contains(global.missing_locations, _i+81000)) {
				global.spotlist[_i] = 0
			} else {
				global.spotlist[_i] = 1
			}
		}
	}
}
