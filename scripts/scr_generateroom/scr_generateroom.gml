function scr_generateroom(argument0, argument1) {
	for(var _xx = argument0-16;_xx <= argument0+16; _xx+=16)
	{
	    for(var _yy = argument1-16;_yy <= argument1+16; _yy+=16)
	    {
	        with (instance_position(_xx,_yy,obj_tile))
	        {
	            global.tiletype[_xx/16,_yy/16] = "not_a_bomb"
	        }
	    }
	}
	global.curbombcount = 0
	while (global.curbombcount < global.bombcount && global.curbombcount < (global.tilewidth*global.tileheight)/5)
	{
		var _xx = irandom_range(0,global.tilewidth-1)
		var _yy = irandom_range(0,global.tileheight-1)
		while (global.tiletype[_xx,_yy] != "none")
		{
			_xx = irandom_range(0,global.tilewidth-1)
			_yy = irandom_range(0,global.tileheight-1)
		}
		global.tiletype[_xx,_yy] = "bomb"
		global.curbombcount++
	}
	var _checksavail = undefined
	var _iie = 0
	global.checksgotten = 0
	for (var _i = 0; _i < array_length(global.spotlist);_i++)
	{
		if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5)
		{
			if (!file_exists("send"+string(_i+81000)))
			{
				_checksavail[_iie] = _i
				global.spotlist[_i] = 0
				_iie++
			}
			else
			{
				global.spotlist[_i] = 1
				global.checksgotten++
			}
		}
	}
	for (var _yy = 0;_yy<global.roomthisheight;_yy++)
	{
	    for(var _xx = 0;_xx<global.roomthiswidth;_xx++)
	    {
	        with(instance_position(_xx*16,_yy*16,obj_tile))
	        {
	            type = global.tiletype[_xx,_yy]
	            if (type == "not_a_bomb")
	                type = "none"
	        }
	    }
	}
}
