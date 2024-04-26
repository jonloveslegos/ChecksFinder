/// @description scr_senditem(spotid)
/// @param spotid
function scr_send_item(argument0) {
	var _payload = "[{\"cmd\":\"LocationChecks\",\"locations\":["+string(argument0)+"]}]"
	var _temp_buffer = buffer_create(0, buffer_grow, 1)
	buffer_seek(_temp_buffer, buffer_seek_start, 0)
	buffer_write(_temp_buffer, buffer_string, _payload)
	//show_message(buffer_peek(_temp_buffer, 0, buffer_string))
	network_send_raw(global.client, _temp_buffer, string_length(_payload), network_send_text)
	buffer_delete(_temp_buffer)
}
