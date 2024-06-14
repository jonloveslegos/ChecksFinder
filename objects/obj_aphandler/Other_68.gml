var _async_value = ds_map_find_value(async_load, "type")
if (_async_value == network_type_non_blocking_connect)
{
	if (ds_map_find_value(async_load, "succeeded") == 1) {
		var _payload = "[{\"cmd\":\"Connect\",\"password\":"+(global.ap.password == ""? "null" : global.ap.password)+",\"name\":\""+global.ap.username+"\",\"version\":{\"major\":0,\"minor\":4,\"build\":6,\"class\":\"Version\"},\"tags\":[\"AP\"], \"items_handling\":7, \"uuid\":"+string(irandom_range(281474976710655, 281474976710655))+",\"game\":\"ChecksFinder\",\"slot_data\":true}]"
		scr_send_packet(_payload)
	} else {
		show_message_async("Failed to connect. Check if server link is correct.")
	}
}
else if (_async_value == network_type_data)
{
	var _payload = buffer_read(ds_map_find_value(async_load, "buffer"), buffer_string)
	var _parsed_message = []
	_parsed_message = json_parse(_payload)
	for (var _i = 0; _i < array_length(_parsed_message); _i++)
	{
		if (_parsed_message[_i].cmd == "Connected")
		{
			//show_message(_parsed_message[i].missing_locations)
			global.missing_locations = []
			global.missing_locations = _parsed_message[_i].missing_locations
			global.checksgotten = 25-array_length(_parsed_message[_i].missing_locations)
			if (global.before_game) {
				global.before_game = false
				room_goto_next()
			}
		}
		else if (_parsed_message[_i].cmd == "ReceivedItems")
		{
			//show_message(_parsed_message[i].items)
			for (var _e = 0; _e < array_length(_parsed_message[_i].items); _e++)
			{
		        if (_parsed_message[_i].items[_e].item == 80000)
		            scr_get_item("width")
		        if (_parsed_message[_i].items[_e].item == 80001)
		            scr_get_item("height")
		        if (_parsed_message[_i].items[_e].item == 80002)
		            scr_get_item("bomb")
			}
		}
		else if (_parsed_message[_i].cmd == "ConnectionRefused")
		{
			show_message_async(string(_parsed_message[_i].errors));
		}
	}
} else if (_async_value == network_type_disconnect) {
	show_message_async("Disconnected. Close this window to reconnect.")
}
