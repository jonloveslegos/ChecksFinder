with(selectable_items[selected_input]) {
	if (object_index == obj_text_input) {
		if (self.id != inst_ap_password) {
			text = keyboard_string
		} else {
			pass_text = keyboard_string
			text = string_repeat("*",string_length(pass_text))
		}
	}
}
