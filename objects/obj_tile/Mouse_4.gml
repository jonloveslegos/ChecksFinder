var flag = false
if (global.canclick == true && global.clicked == false) {
	flag = scr_updateobtains()
}
if (flag) {
	room_restart()
} else {
	scr_revealtile()
}
