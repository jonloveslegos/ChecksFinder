/// @description global
function fishfinder_s() {
	if (global.fishfinder_countdown == 2) {
		global.fishfinder_countdown = 3
		show_debug_message("FI{S}H Countdown is at {0}",global.fishfinder_countdown)
	} else {
		global.fishfinder_countdown = 0
		show_debug_message("FI{S}H Countdown failed, restart to {0}",global.fishfinder_countdown)
	}
}

if (room == rm_ap_data) {
	with(obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_button) {
			fishfinder_s()
		}
	}
} else {
	fishfinder_s()
}
