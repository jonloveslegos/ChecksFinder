if (room == rm_ap_data) {
	if (keyboard_check(vk_shift)) {
		scr_update_select(selected_input - 1)
	} else {
		scr_update_select(selected_input + 1)
	}
}
