global.canclick = true
global.clicked = false
scr_updateobtains()
won = false
for (var yy = 0;yy<global.tileheight;yy++)
{
    for (var xx = 0;xx<global.tilewidth;xx++)
    {
        global.tiletype[xx,yy] = "none"
    }
}
room_width = global.tilewidth*16
room_height = global.tileheight*16
global.roomthisheight = global.tileheight
global.roomthiswidth = global.tilewidth
camera_set_view_size(view_get_camera(0), room_width, room_height*1.25);
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
for (var yy = 0;yy<global.tileheight;yy++)
{
    for (var xx = 0;xx<global.tilewidth;xx++)
    {
        with instance_create(xx*16,yy*16,obj_tile)
        {
            type = global.tiletype[xx,yy]
        }
    }
}

