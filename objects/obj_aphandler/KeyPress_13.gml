if (room == rm_apstuff) {
	with(obj_aphandler.selectable_items[obj_aphandler.selected_input]) {
		if (object_index == obj_button) {
			scr_save_connection_data()
			scr_connect_to_ap()
		}
	}
}
