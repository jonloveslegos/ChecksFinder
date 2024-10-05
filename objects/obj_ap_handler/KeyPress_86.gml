/// @description Copy-paste
if (room == rm_ap_data) {
	if (keyboard_check(vk_control)) {
		keyboard_string += clipboard_get_text()
	}
}
