/// @description Fish
if (global.fishfinder_countdown == 3) {
	global.fishfinder_countdown = 0
	show_debug_message("FIS{H} Countdown was successful")
	global.other_settings.enable_fishfinder ^= true
} else {
	global.fishfinder_countdown = 0
	show_debug_message("FIS{H} Countdown failed, restart to {0}",global.fishfinder_countdown)
}