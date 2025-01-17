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
			global.ap.deathlink = _parsed_message[_i].slot_data.deathlink
			global.missing_locations = []
			global.missing_locations = _parsed_message[_i].missing_locations
			global.checksgotten = 25-array_length(_parsed_message[_i].missing_locations)
			if (array_length(global.last_payload) > 0) {
				scr_send_packet(global.last_payload)
			}
			// Update Connection Tags if DeathLink is enabled
			if (global.ap.deathlink == 1) {
				var _data = [{
					cmd: "ConnectUpdate",
					tags: ["DeathLink"]
				}]
				scr_send_packet(_data, false, false)
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
		} else if (_parsed_message[_i].cmd == "Bounced" ) {
			var _has_tags = struct_exists(_parsed_message[_i], "tags")
			if (_has_tags) {
				var _got_deathlink = array_contains(_parsed_message[_i].tags, "DeathLink")
				if (global.ap.deathlink == 1 && _got_deathlink) {
					// Clear Board similar to clicking a bomb
					for (var _yy = 0;_yy<global.roomthisheight;_yy++) {
						for (var _xx = 0;_xx<global.roomthiswidth;_xx++) {
							with (instance_position(_xx*16+1,_yy*16+1,obj_tile)) {
								if (type == "none") {
									scr_gen_pieces(x,y,global.tile_data.background)
								}
								if (type == "bomb") {
									scr_gen_pieces(x,y,global.tile_data.bomb)
								}
								instance_destroy(obj_tile_controller)
							}
						}
					}
					obj_tile.alarm[0] = 30
					audio_play_sound(snd_explosion,0,false)
				}
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
