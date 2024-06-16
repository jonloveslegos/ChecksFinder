var _flag = false
if (
	global.canclick == true && 
	global.clicked == false && 
	obj_tile_controller.alarm[1] == -1 &&
    global.layout_update_required
) {
	obj_tile_controller.alarm[1] = 30*5
	room_restart()	
} else {
	scr_reveal_tile(self)
}
