if (image_index != global.tile_data.bomb.piece_index && image_index != global.tile_data.bomb.piece_index + 1) {
	shader_set(sh_cond)
}
draw_self()
if (image_index != global.tile_data.bomb.piece_index && image_index != global.tile_data.bomb.piece_index + 1) {
	shader_reset()
}
