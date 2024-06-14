layer_background_blend(layer_background_get_id(layer_get_id("Colour_main")), global.game_color.ui_background)
draw_set_colour(global.game_color.ui_text)
draw_set_halign(fa_left)
draw_set_font(fnt_main)


with(inst_ap_link) {
	text = "wss://archipelago.gg"
	highlighted = true
}
with(inst_ap_port) {
	text = "38281"
}
with(inst_ap_slotname) {
	text = "Player1"
}
with(inst_ap_password) {
	text = ""
}
with(inst_btn_online) {
	text = "Play Online"
}

selectable_items = [inst_ap_link,inst_ap_port,inst_ap_slotname,inst_ap_password,inst_btn_online]
selected_input = 0
keyboard_string = selectable_items[selected_input].text
for (var _i = 0; _i < array_length(selectable_items); _i++) {
	selectable_items[_i].selectable_index = _i
}
