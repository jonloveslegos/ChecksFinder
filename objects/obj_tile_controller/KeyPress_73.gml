if (global.fishfinder_countdown == 1) {
	global.fishfinder_countdown = 2
	show_debug_message("FISH Countdown is at {0}",global.fishfinder_countdown)
} else {
	global.fishfinder_countdown = 0
	show_debug_message("FISH Countdown failed, restart to {0}",global.fishfinder_countdown)
}
