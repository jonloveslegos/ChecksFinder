with(obj_aphandler.selectable_items[obj_aphandler.selected_input]) {
	if (object_index == obj_button) {
		scr_save_connection_data()
		network_connect_raw_async(global.client, global.ap.server, global.ap.port)
	}
}
