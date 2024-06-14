function scr_update_select(argument) {
	obj_aphandler.selectable_items[obj_aphandler.selected_input].highlighted = false
	obj_aphandler.selected_input = argument
	if (obj_aphandler.selected_input >= array_length(obj_aphandler.selectable_items)) {
		obj_aphandler.selected_input = 0
	}
	if (obj_aphandler.selected_input < 0) {
		obj_aphandler.selected_input = array_length(obj_aphandler.selectable_items) - 1
	}
	with (obj_aphandler.selectable_items[obj_aphandler.selected_input]) {
		if (object_index == obj_text_input) {
			keyboard_string = text
		}
		highlighted = true
	}
}
