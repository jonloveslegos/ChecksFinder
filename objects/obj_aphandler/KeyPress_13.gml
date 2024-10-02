if (room == rm_apstuff) {
	with(obj_aphandler.selectable_items[obj_aphandler.selected_input]) {
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
