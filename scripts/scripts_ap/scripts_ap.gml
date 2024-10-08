function scr_is_layout_update_required() {
	return global.roomthisheight != global.tileheight || global.roomthiswidth != global.tilewidth
}

function scr_ap_update_checks() {
	for (var _i = 0; _i < array_length(global.spotlist);_i++) {
		if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5) {
			if (array_contains(global.missing_locations, _i+81000)) {
				global.spotlist[_i] = int64(0)
			} else {
				global.spotlist[_i] = int64(_i+81000)
			}
		}
	}
}

function scr_send_packet(_data, _send_bounce = true, _do_backup = true) {
	//bounce is used to guarantee server responce, to verify that the server is up
	var __data
	if (_send_bounce) {
		__data = array_concat(_data, [{ cmd: "Bounce", slots: [global.ap.slotid], data: { ping: "pong" } }])
	} else {
		__data = _data
	}
	var _payload = json_stringify(__data)
	if (_do_backup) {
		global.last_payload = _data
	}
	obj_ap_handler.alarm[0] = 30*5 // timeout before asking to reconnect
	var _temp_buffer = buffer_create(0, buffer_grow, 1)
	buffer_seek(_temp_buffer, buffer_seek_start, 0)
	buffer_write(_temp_buffer, buffer_string, _payload)
	buffer_seek(_temp_buffer, buffer_seek_start, 0)
	show_debug_message("sending payload: {0}", buffer_read(_temp_buffer, buffer_string))
	show_debug_message("payload size: {0}", buffer_tell(_temp_buffer) - 1)
	network_send_raw(global.client, _temp_buffer, buffer_tell(_temp_buffer) - 1, network_send_text)
	buffer_delete(_temp_buffer)
}

function scr_save_connection_data() {
	var _is_valid = scr_is_url_valid(inst_ap_server.text)
	global.ap = {
		is_server_valid: _is_valid,
		server: _is_valid ? scr_format_url(inst_ap_server.text) : inst_ap_server.text,
		port: inst_ap_port.text,
		slotname: inst_ap_slotname.text,
		password: inst_ap_password.pass_text,
		uuid: global.ap.uuid,
	}
	inst_ap_server.text = global.ap.server
	ini_open(global.save_file)
	ini_write_string("Archipelago", "server", global.ap.server)
	ini_write_string("Archipelago", "port", global.ap.port)
	ini_write_string("Archipelago", "slotname", global.ap.slotname)
	ini_write_string("Archipelago", "password", global.ap.password)
	ini_write_string("Archipelago", "uuid", global.ap.uuid)
	ini_close()
}

function scr_load_connection_data() {
	ini_open(global.save_file)
	var _server = ini_read_string("Archipelago", "server", "wss://archipelago.gg")
	var _is_valid = scr_is_url_valid(_server)
	global.ap = {
		is_server_valid: _is_valid,
		server: _is_valid ? scr_format_url(_server) : _server,
		port: ini_read_string("Archipelago", "port", "38281"),
		slotname: ini_read_string("Archipelago", "slotname", "Player"),
		password: ini_read_string("Archipelago", "password", ""),
		uuid: ini_read_string("Archipelago", "uuid", string(irandom_range(0, 281474976710655))),
	}
	ini_close()
}

function scr_connect_to_ap() {
	if (!is_undefined(global.client)) {
		network_destroy(global.client);
	}
	global.client = network_create_socket(network_socket_ws)
	obj_ap_handler.alarm[1] = 130
	network_connect_raw_async(global.client, global.ap.server, global.ap.port)
}

function scr_is_url_valid(_server) {
	return string_starts_with(_server, "ws://") ||
		string_starts_with(_server, "wss://") ||
		string_starts_with(_server, "http://") ||
		string_starts_with(_server, "https://")
}


function scr_format_url(_server) {
	if (string_starts_with(_server, "h")) {
		return string_concat("ws",string_delete(_server, 0, 4))
	} else return _server
}
