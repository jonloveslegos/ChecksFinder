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
	obj_aphandler.alarm[0] = 30*5 // timeout before asking to reconnect
	show_debug_message("sent payload: {0}", _payload)
	var _temp_buffer = buffer_create(0, buffer_grow, 1)
	buffer_seek(_temp_buffer, buffer_seek_start, 0)
	buffer_write(_temp_buffer, buffer_string, _payload)
	network_send_raw(global.client, _temp_buffer, string_length(_payload), network_send_text)
	buffer_delete(_temp_buffer)
}

function scr_save_connection_data() {
	global.ap = {
		server: inst_ap_server.text,
		port: inst_ap_port.text,
		slotname: inst_ap_slotname.text,
		password: inst_ap_password.pass_text,
		uuid: global.ap.uuid,
	}
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
	global.ap = {
		server: ini_read_string("Archipelago", "server", "wss://archipelago.gg"),
		port: ini_read_string("Archipelago", "port", "38281"),
		slotname: ini_read_string("Archipelago", "slotname", "Player1"),
		password: ini_read_string("Archipelago", "password", ""),
		uuid: ini_read_string("Archipelago", "uuid", string(irandom_range(0, 281474976710655))),
	}
	ini_close()
}

function scr_connect_to_ap() {
	if (!is_undefined(global.client)) {
		network_destroy(global.client);
	}
	global.client = network_create_socket(network_socket_ws);
	network_connect_raw_async(global.client, global.ap.server, global.ap.port)
}
