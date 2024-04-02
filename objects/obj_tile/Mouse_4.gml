var _flag = false
if (global.canclick == true && global.clicked == false && obj_tilecontroller.alarm[1] == -1) {
	_flag = scr_updateobtains()
	if (_flag) {
		obj_tilecontroller.alarm[1] = 30*5
	}
}
if (_flag) {
	room_restart()
} else {
	scr_revealtile()
}
