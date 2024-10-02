with(selectable_items[selected_input]) {
	if (object_index == obj_text_input) {
		if (self.id == inst_ap_password) {
			pass_text = keyboard_string
			text = scr_hidden_string(pass_text)
		} else {
			text = keyboard_string
		}
	}
}
