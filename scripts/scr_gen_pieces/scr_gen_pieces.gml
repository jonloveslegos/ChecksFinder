function scr_gen_pieces(_xx, _yy, _tile_data){
	if (global.other_settings.pieces_count >= 4) {
		with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
		{
			// a bomb must have only 1 center; regular tiles can have multiple different corners
		    image_index = _tile_data.piece_index + (_tile_data == global.tile_data.bomb ? 0 : 1)
			image_blend = _tile_data.color
		}
	}
	if (global.other_settings.pieces_count >= 3) {
		with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
		{
			// a bomb must have only 1 center; regular tiles can have multiple different corners
		    image_index = _tile_data.piece_index + (_tile_data == global.tile_data.bomb ? 0 : 1)
			image_blend = _tile_data.color
		}
	}
	if (global.other_settings.pieces_count >= 2) {
		with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
		{
		    image_index = _tile_data.piece_index
			image_blend = _tile_data.color
		}
	}
	if (global.other_settings.pieces_count >= 1) {
		with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
		{
			// chooses between 0 tile and 1 tile, with heavier weight towards 1 based on
			//how large the setting is, to give more weight to center piece
			var _rng = irandom_range(0, global.other_settings.pieces_count)
		    image_index = _tile_data.piece_index + (_rng <= 1 ? _rng : 1)
			image_blend = _tile_data.color
		}
	}
}
