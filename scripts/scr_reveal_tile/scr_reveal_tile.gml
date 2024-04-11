function scr_reveal_tile() {
	if (global.canclick == true && revealed == false && marked == false)
	{
	    revealed = true
	    scr_gen_particles(x,y,0)
	    if (global.clicked == false)
	    {
	        global.clicked = true
	        scr_generate_room(x, y)
	    }
	    if (type == "bomb")
	    {
	        with(obj_tile)
	        {
				if (!revealed) {
					scr_gen_particles(x,y,0)
				}
	            revealed = true
	        }
	        global.canclick = false
	        alarm[0] = 30
	        audio_play_sound(snd_explosion,0,false)
	    }
	    else
	    {
	        if (type == "none" && scr_return_amt_near_type("bomb") == 0)
	        {
	            scr_uncover_surrounding()
	        }
	        audio_play_sound(snd_digright,0,false)
	    }
	}
	else if (global.canclick == true && revealed == true)
	{
	    var _flags = 0
	    var _bombs = 0
	    with (instance_position(x,y-16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x,y+16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x-16,y,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x+16,y,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x-16,y-16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x-16,y+16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x+16,y-16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    with (instance_position(x+16,y+16,obj_tile))
	    {
	        if (marked == true)
	        {
	            _flags++
	        }
	        else if (type == "bomb")
	        {
	            _bombs++
	        }
	    }
	    if (_flags == scr_return_amt_near_type("bomb"))
	    {
	        if (_bombs > 0)
	        {
	            with(obj_tile)
	            {
					if (!revealed) {
						scr_gen_particles(x,y,0)
					}
	                revealed = true
	            }
	            global.canclick = false
	            alarm[0] = 30
	            audio_play_sound(snd_explosion,0,false)
	        }
	        else
	        {
	            scr_uncover_surrounding()
	            audio_play_sound(snd_digright,0,false)
	        }
	    }
	}
}
