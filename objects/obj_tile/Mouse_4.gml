var _flag = false
if (global.canclick == true && global.clicked == false) {
	_flag = scr_updateobtains()
}
if (_flag) {
	room_restart()
} else {
	scr_revealtile()
}
