function scr_generate_room(argument0, argument1) {
	for(var _xx = argument0-16;_xx <= argument0+16; _xx+=16)
	{
	    for(var _yy = argument1-16;_yy <= argument1+16; _yy+=16)
	    {
	        with (instance_position(_xx+1,_yy+1,obj_tile))
	        {
	            global.tiletype[_xx div 16,_yy div 16] = "not_a_bomb"
	        }
	    }
	}
	global.roomthisbomb = global.bombcount
	global.curbombcount = 0
	while (global.curbombcount < global.roomthisbomb && global.curbombcount < (global.roomthiswidth*global.roomthisheight)/5)
	{
		var _xx = 0
		var _yy = 0
		do {
			_xx = irandom_range(0,global.roomthiswidth-1)
			_yy = irandom_range(0,global.roomthisheight-1)
		} until (global.tiletype[_xx,_yy] == "none")
		
		global.tiletype[_xx,_yy] = "bomb"
		global.curbombcount++
	}
	for (var _yy = 0;_yy<global.roomthisheight;_yy++)
	{
	    for(var _xx = 0;_xx<global.roomthiswidth;_xx++)
	    {
	        with(instance_position(_xx*16+1,_yy*16+1,obj_tile))
	        {
	            type = global.tiletype[_xx,_yy]
	            if (type == "not_a_bomb")
	                type = "none"
	        }
	    }
	}
}
