global.fn_uncover = function(_tile) {
	with (_tile) {
		if (type == "none" && revealed == false) {
			revealed = true
			marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
			if (scr_count_surrounding(self, global.fn_is_bomb) == 0)
	        {
	            scr_uncover_surrounding(self)
	        }
		}
	}
}

function scr_uncover_surrounding(_tile) {
	scr_count_surrounding(_tile, global.fn_uncover)
}
