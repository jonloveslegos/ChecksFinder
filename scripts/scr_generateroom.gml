//scr_generateroom(x, y)
    for(var xx = argument0-16;xx <= argument0+16; xx+=16)
    {
        for(var yy = argument1-16;yy <= argument1+16; yy+=16)
        {
            with (instance_position(xx,yy,obj_tile))
            {
                global.tiletype[xx/16,yy/16] = "not_a_bomb"
            }
        }
    }
    global.curbombcount = 0
	while (global.curbombcount < global.bombcount && global.curbombcount < (global.tilewidth*global.tileheight)/5)
	{
		var xx = irandom_range(0,global.tilewidth-1)
		var yy = irandom_range(0,global.tileheight-1)
		while (global.tiletype[xx,yy] != "none")
		{
			xx = irandom_range(0,global.tilewidth-1)
			yy = irandom_range(0,global.tileheight-1)
		}
		global.tiletype[xx,yy] = "bomb"
		global.curbombcount++
	}
	var amt = 20-5+10-5+10-5
	var checksavail = undefined
	var iie = 0
	global.checksgotten = 0
	for (var i = 0; i < array_length_1d(global.spotlist);i++)
	{
		if (i < global.tilewidth+global.tileheight+global.bombcount-5-5)
		{
			if (!file_exists("send"+string(i+81000)))
			{
				checksavail[iie] = i
				global.spotlist[i] = 0
				iie++
			}
			else
			{
				global.spotlist[i] = 1
				global.checksgotten++
			}
		}
	}
    for (var yy = 0;yy<global.roomthisheight;yy++)
    {
        for(var xx = 0;xx<global.roomthiswidth;xx++)
        {
            with(instance_position(xx*16,yy*16,obj_tile))
            {
                type = global.tiletype[xx,yy]
                if (type == "not_a_bomb")
                    type = "none"
            }
        }
    }
