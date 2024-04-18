var _flag = false
if (
	global.canclick == true && 
	global.clicked == false && 
	obj_tile_controller.alarm[1] == -1
) {
	if (!global.other_settings.auto_update) {
		_flag = scr_updateobtains()
	} else {
		_flag = global.layout_update_required
	}
}
if (_flag) {
	obj_tile_controller.alarm[1] = 30*5
	room_restart()	
} else {
	scr_reveal_tile(self)
}
