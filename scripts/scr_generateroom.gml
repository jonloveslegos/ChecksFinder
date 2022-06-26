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
    bombcount = 0
    while (bombcount < global.roomthisbomb && bombcount < (global.roomthiswidth*global.roomthisheight) div 5)
    {
        var xx = irandom_range(0,global.roomthiswidth-1)
        var yy = irandom_range(0,global.roomthisheight-1)
        while (global.tiletype[xx,yy] != "none")
        {
            xx = irandom_range(0,global.roomthiswidth-1)
            yy = irandom_range(0,global.roomthisheight-1)
        }
        global.tiletype[xx,yy] = "bomb"
        bombcount++
    }
    
    checkcount = 0
    var amt = 20-5+10-5+10-5
    var checksavail = undefined
    var iie = 0
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
            }
        }
    }
    while (checkcount < 1 && checkcount < array_length_1d(checksavail))
    {
        var xx = irandom_range(0,global.roomthiswidth-1)
        var yy = irandom_range(0,global.roomthisheight-1)
        while (global.tiletype[xx,yy] == "bomb")
        {
            xx = irandom_range(0,global.roomthiswidth-1)
            yy = irandom_range(0,global.roomthisheight-1)
        }
        global.tiletype[xx,yy] = "check"
        checkcount++
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
                if (type == "check")
                {
                    var chose = irandom_range(0,array_length_1d(checksavail)-1)
                    typeplus = checksavail[chose]
                    var templst = undefined
                    for (var ea = 0; ea < chose;ea++)
                    {
                        templst[ea] = checksavail[ea]
                    }
                    for (var ea = chose; ea < array_length_1d(checksavail)-1;ea++)
                    {
                        templst[ea] = checksavail[ea+1]
                    }
                    checksavail = templst
                }
            }
            
        }
    }
