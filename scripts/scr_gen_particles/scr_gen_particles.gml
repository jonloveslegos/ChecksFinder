function scr_gen_particles(_xx, _yy, _particle_index){
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _particle_index
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _particle_index
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _particle_index
	}
	with instance_create_layer(_xx+8, _yy+8, "Particles", obj_piece)
	{
	    image_index = _particle_index+1
	}
}