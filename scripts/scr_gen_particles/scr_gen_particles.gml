function scr_gen_particles(_xx, _yy, _tile_data){
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _tile_data.piece_index
		image_blend = _tile_data.color
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _tile_data.piece_index
		image_blend = _tile_data.color
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _tile_data.piece_index
		image_blend = _tile_data.color
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _tile_data.piece_index+1
		image_blend = _tile_data.color
	}
}
