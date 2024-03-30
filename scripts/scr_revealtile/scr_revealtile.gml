function scr_revealtile() {
	if (global.canclick == true && revealed == false)
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
	        if (type == "bomb")
	        {
	            var xx = irandom_range(0,global.roomthiswidth-1)
	            var yy = irandom_range(0,global.roomthisheight-1)
	            while (global.tiletype[xx,yy] != "none")
	            {
	                xx = irandom_range(0,global.roomthiswidth-1)
	                yy = irandom_range(0,global.roomthisheight-1)
	            }
	            type = "none"
	            global.tiletype[xx,yy] = "bomb"
	            with(instance_position(xx,yy,obj_tile))
	            {
	                type = "bomb"
	            }
	        }
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



}
