function scr_revealtile() {
	if (global.canclick == true && revealed == false && marked == false)
	{
	    revealed = true
	    with instance_create(x+8,y+8,obj_piece)
	    {
	        image_index = 0
	    }
	    with instance_create(x+8,y+8,obj_piece)
	    {
	        image_index = 0
	    }
	    with instance_create(x+8,y+8,obj_piece)
	    {
	        image_index = 0
	    }
	    with instance_create(x+8,y+8,obj_piece)
	    {
	        image_index = 1
	    }
	    if (global.clicked == false)
	    {
	        global.clicked = true
	        scr_generateroom(x, y)
	    }
	    if (type == "bomb")
	    {
	        with(obj_tile)
	        {
	            revealed = true
	        }
	        global.canclick = false
	        alarm[0] = 30
	        audio_play_sound(snd_explosion,0,false)
	    }
	    else
	    {
	        if (type == "none" && scr_returnamtneartype("bomb") == 0)
	        {
	            scr_uncoversurrounding()
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
	    if (_flags == scr_returnamtneartype("bomb"))
	    {
	        if (_bombs > 0)
	        {
	            with(obj_tile)
	            {
	                revealed = true
	            }
	            global.canclick = false
	            alarm[0] = 30
	            audio_play_sound(snd_explosion,0,false)
	        }
	        else
	        {
	            scr_uncoversurrounding()
	            audio_play_sound(snd_digright,0,false)
	        }
	    }
	}
}
