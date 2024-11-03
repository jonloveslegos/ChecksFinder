/// @description global
function fishfinder_i() {
	if (global.fishfinder_countdown == 1) {
		global.fishfinder_countdown = 2
		show_debug_message("F{I}SH Countdown is at {0}",global.fishfinder_countdown)
	} else {
		global.fishfinder_countdown = 0
		show_debug_message("F{I}SH Countdown failed, restart to {0}",global.fishfinder_countdown)
	}
}

if (room == rm_ap_data) {
	with(obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_button) {
			fishfinder_i()
		}
	}
} else {
	fishfinder_i()
}
