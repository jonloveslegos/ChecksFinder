if (global.fishfinder_countdown == 3) {
	global.fishfinder_countdown = 0
	show_debug_message("FISH Countdown was successful")
	global.other_settings.enable_fishfinder ^= true
} else {
	global.fishfinder_countdown = 0
	show_debug_message("FISH Countdown failed, restart to {0}",global.fishfinder_countdown)
}