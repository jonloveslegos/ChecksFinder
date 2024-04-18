/// @description Obtains updater
if (scr_ap_load_data()) {
	global.layout_update_required = true
}
scr_ap_update_checks()
alarm[2] = 30
