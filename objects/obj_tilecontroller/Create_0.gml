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
global.roomthisbomb = global.bombcount
camera_set_view_size(view_get_camera(0), room_width, room_height*1.25);

for (var yy = 0;yy<global.tileheight;yy++)
{
    for (var xx = 0;xx<global.tilewidth;xx++)
    {
        with instance_create(xx*16,yy*16,obj_tile)
        {
            type = "none"
        }
    }
}

