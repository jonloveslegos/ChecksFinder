draw_set_halign(fa_left)
draw_set_font(fnt_main)
draw_set_colour(global.game_color.ui_text)

with(inst_ap_link) {
	
	draw_text_transformed(x, y-7, "Server IP address", 0.08, 0.08, 0)
	text_colour = global.game_color.input_text
	text = "wss://archipelago.gg"
}
with(inst_ap_port) {
	draw_text_transformed(x, y-7, "Server port", 0.08, 0.08, 0)
	text_colour = global.game_color.input_text
	text = "23423"
}
with(inst_ap_slotname) {
	draw_text_transformed(x, y-7, "Slot name", 0.08, 0.08, 0)
	text_colour = global.game_color.input_text
	text = "Player1"
}
with(inst_ap_password) {
	draw_text_transformed(x, y-7, "Server password", 0.08, 0.08, 0)
	text_colour = global.game_color.input_text
	text = "12345"
}
with(inst_btn_online) {
	text = "Play Online"
	text_colour = global.game_color.button_text
}