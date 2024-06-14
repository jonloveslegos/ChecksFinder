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

function scr_send_packet(argument) {
	var _temp_buffer = buffer_create(0, buffer_grow, 1)
	buffer_seek(_temp_buffer, buffer_seek_start, 0)
	buffer_write(_temp_buffer, buffer_string, argument)
	network_send_raw(global.client, _temp_buffer, string_length(argument), network_send_text)
	buffer_delete(_temp_buffer)
}

function scr_save_connection_data() {
	global.client = network_create_socket(network_socket_ws)
	global.ap = {
		server: inst_ap_link.text,
		port: inst_ap_port.text,
		username: inst_ap_slotname.text,
		password: inst_ap_password.text,
	}
}
