function scr_update_select(argument) {
	obj_ap_handler.selectable_items[obj_ap_handler.selected_input].highlighted = false
	obj_ap_handler.selected_input = argument
	if (obj_ap_handler.selected_input >= array_length(obj_ap_handler.selectable_items)) {
		obj_ap_handler.selected_input = 0
	}
	if (obj_ap_handler.selected_input < 0) {
		obj_ap_handler.selected_input = array_length(obj_ap_handler.selectable_items) - 1
	}
	with (obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_text_input) {
			keyboard_string = text
		}
		highlighted = true
	}
}
