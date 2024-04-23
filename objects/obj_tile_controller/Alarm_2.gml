/// @description Obtains updater
global.layout_update_required = scr_ap_load_data() || global.layout_update_required
scr_ap_update_checks()
alarm[2] = 30
