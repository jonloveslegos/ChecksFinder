/// @description global
function fishfinder_f() {
	show_debug_message("start {F}ISH countdown")
	global.fishfinder_countdown = 1
}

if (room == rm_ap_data) {
	with(obj_ap_handler.selectable_items[obj_ap_handler.selected_input]) {
		if (object_index == obj_button) {
			fishfinder_f()
		}
	}
} else {
	fishfinder_f()
}
