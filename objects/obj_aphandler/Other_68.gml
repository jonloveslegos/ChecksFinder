if (ds_map_find_value(async_load, "type") == network_type_non_blocking_connect)
{
	if (ds_map_find_value(async_load, "succeeded") == 1)
	{
		var _player = get_string("Player name", "")
		var _payload = "[{\"cmd\":\"Connect\",\"password\":null,\"name\":\""+_player+"\",\"version\":{\"major\":0,\"minor\":4,\"build\":6,\"class\":\"Version\"},\"tags\":[\"AP\"], \"items_handling\":7, \"uuid\":"+string(irandom_range(281474976710655, 281474976710655))+",\"game\":\"ChecksFinder\",\"slot_data\":true}]"
		var _temp_buffer = buffer_create(0, buffer_grow, 1)
		buffer_seek(_temp_buffer, buffer_seek_start, 0)
		buffer_write(_temp_buffer, buffer_string, _payload)
		//show_error(buffer_peek(_temp_buffer, 0, buffer_string), false)
		network_send_raw(global.client, _temp_buffer, string_length(_payload), network_send_text)
		buffer_delete(_temp_buffer)
	}
}
else if (ds_map_find_value(async_load, "type") == network_type_data)
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
			room_goto_next()
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
			var _player = get_string("Player name", "")
			_payload = "[{\"cmd\":\"Connect\",\"password\":null,\"name\":\""+_player+"\",\"version\":{\"major\":0,\"minor\":4,\"build\":6,\"class\":\"Version\"},\"tags\":[\"AP\"], \"items_handling\":7, \"uuid\":"+string(irandom_range(281474976710655, 281474976710655))+",\"game\":\"ChecksFinder\",\"slot_data\":true}]"
			var _temp_buffer = buffer_create(0, buffer_grow, 1)
			buffer_seek(_temp_buffer, buffer_seek_start, 0)
			buffer_write(_temp_buffer, buffer_string, _payload)
			//show_error(buffer_peek(_temp_buffer, 0, buffer_string), false)
			network_send_raw(global.client, _temp_buffer, string_length(_payload), network_send_text)
			buffer_delete(_temp_buffer)
		}
	}
}
