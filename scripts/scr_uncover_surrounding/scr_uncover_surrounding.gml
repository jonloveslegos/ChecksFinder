function scr_uncover_surrounding() {
	with (instance_position(x,y-16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x,y+16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x-16,y,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x+16,y,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x-16,y-16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x-16,y+16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x+16,y-16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
	with (instance_position(x+16,y+16,obj_tile))
	{
	    if (type == "none" && revealed == false)
	    {
	        revealed = true
	        marked = false
			scr_gen_particles(x,y,global.tile_data.foreground)
	        if (scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	    }
	}
}
