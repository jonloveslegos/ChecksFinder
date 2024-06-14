layer_background_blend(layer_background_get_id(layer_get_id("Colour_main")), global.game_color.ui_background)
draw_set_colour(global.game_color.ui_text)
draw_set_halign(fa_left)
draw_set_font(fnt_main)
scr_load_connection_data()

with(inst_ap_server) {
	text = global.ap.server
	highlighted = true
}
with(inst_ap_port) {
	text = global.ap.port
}
with(inst_ap_slotname) {
	text = global.ap.slotname
}
with(inst_ap_password) {
	text = global.ap.password
}
with(inst_btn_online) {
	text = "Play Online"
}

selectable_items = [inst_ap_server,inst_ap_port,inst_ap_slotname,inst_ap_password,inst_btn_online]
selected_input = 0
keyboard_string = selectable_items[selected_input].text
for (var _i = 0; _i < array_length(selectable_items); _i++) {
	selectable_items[_i].selectable_index = _i
}
