if (global.fishfinder_countdown == 2) {
	global.fishfinder_countdown = 3
	show_debug_message("FISH Countdown is at {0}",global.fishfinder_countdown)
} else {
	global.fishfinder_countdown = 0
	show_debug_message("FISH Countdown failed, restart to {0}",global.fishfinder_countdown)
}
