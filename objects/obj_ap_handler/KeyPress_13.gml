if (room == rm_ap_data) {
	with(obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_button) {
			scr_save_connection_data()
			if (global.ap.is_server_valid) {
				scr_connect_to_ap()
			} else {
				show_message_async("Server url must start with ws://, wss://, http://, or https://")
			}	
		}
	}
}
