obj_ap_handler.alarm[1] = -1
var _async_value = ds_map_find_value(async_load, "type")
if (_async_value == network_type_non_blocking_connect) {
	if (ds_map_find_value(async_load, "succeeded") != 1) {
		show_message_async("Failed to connect. Check if multiworld server link and port are correct, and that the server is up.")
	}
}
else if (_async_value == network_type_data) {
	var _payload = buffer_read(ds_map_find_value(async_load, "buffer"), buffer_string)
	show_debug_message("received payload: {0}",_payload)
	alarm[0] = -1 //reset reconnection timeout, as we got a responce from the server 
	var _parsed_message = []
	_parsed_message = json_parse(_payload)
	for (var _i = 0; _i < array_length(_parsed_message); _i++) {
		if (_parsed_message[_i].cmd == "RoomInfo") { 
			var _data = [{
				cmd: "Connect",
				name: global.ap.slotname,
				password: global.ap.password == "" ? "None" : global.ap.password,
				version: {
					major: int64(0),
					minor: int64(5),
					build: int64(0),
					class: "Version"
				},
				tags: [],
				items_handling: int64(7),
				uuid: global.ap.uuid,
				game: "ChecksFinder",
				slot_data: true
			}]
			scr_send_packet(_data, false, false)
		} else if (_parsed_message[_i].cmd == "Connected") {
			global.ap.slotid = _parsed_message[_i].slot
			global.missing_locations = []
			global.missing_locations = _parsed_message[_i].missing_locations
			global.checksgotten = 25-array_length(_parsed_message[_i].missing_locations)
			if (array_length(global.last_payload) > 0) {
				scr_send_packet(global.last_payload)
			}
			if (global.before_game) {
				global.before_game = false
				room_goto_next()
			}
		}
		else if (_parsed_message[_i].cmd == "ReceivedItems") {
			var _index = _parsed_message[_i].index
			for (var _e = 0; _e < array_length(_parsed_message[_i].items); _e++) {
		        if (_parsed_message[_i].items[_e].item == 80000)
		            scr_get_item("width", _index)
		        if (_parsed_message[_i].items[_e].item == 80001)
		            scr_get_item("height", _index)
		        if (_parsed_message[_i].items[_e].item == 80002)
		            scr_get_item("bomb", _index)
				_index++
			}
		} else if (_parsed_message[_i].cmd == "ConnectionRefused") {
			show_message_async(string(_parsed_message[_i].errors));
		} else if (_parsed_message[_i].cmd == "RoomUpdate") {
			if (struct_exists(_parsed_message[_i], "checked_locations")) {
				for (var _j = 0; _j < array_length(_parsed_message[_i].checked_locations); _j++) {
					var _index = -1
					for (var _k = array_length(global.missing_locations) - 1; _k >= 0;) {
						_index = _k
						if (global.missing_locations[_k] == _parsed_message[_i].checked_locations[_j]) {
							break
						}
						_k--
						_index = _k
					}
					if (_index != -1) {
						array_delete(global.missing_locations, _index, 1)
					}
				}
			}
		} else if (_parsed_message[_i].cmd == "PrintJSON") {
			var _message = ""
			var _has_type = struct_exists(_parsed_message[_i], "type")
			if (_has_type && _parsed_message[_i].type == "Tutorial") {
				_message += "Now that you are connected, you could have used commands, but they are not implemented."
			} else for (var _j = 0; _j < array_length(_parsed_message[_i].data); _j++) {
				if (struct_exists(_parsed_message[_i].data[_j], "text")) {
					_message += _parsed_message[_i].data[_j].text
				}
			}
			show_debug_message(_message)
		}
	}
}
