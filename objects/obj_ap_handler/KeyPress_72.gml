/// @description global
function fishfinder_h() {
	if (global.fishfinder_countdown == 3) {
		global.fishfinder_countdown = 0
		show_debug_message("FIS{H} Countdown was successful")
		global.other_settings.enable_fishfinder ^= true
	} else {
		global.fishfinder_countdown = 0
		show_debug_message("FIS{H} Countdown failed, restart to {0}",global.fishfinder_countdown)
	}
}

if (room == rm_ap_data) {
	with(obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_button) {
			fishfinder_h()
		}
	}
} else {
	fishfinder_h()
}
