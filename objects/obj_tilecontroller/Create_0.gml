global.canclick = true
global.clicked = false
won = false
scr_updateobtains()
for (var _yy = 0; _yy < global.tileheight; _yy++)
{
    for (var _xx = 0; _xx < global.tilewidth; _xx++)
    {
        global.tiletype[_xx,_yy] = "none"
    }
}
room_width = global.tilewidth*16
room_height = global.tileheight*16
global.roomthisheight = global.tileheight
global.roomthiswidth = global.tilewidth
global.roomthisbomb = global.bombcount
camera_set_view_size(view_get_camera(0), room_width, room_height*1.25);

for (var _yy = 0; _yy<global.tileheight; _yy++)
{
    for (var _xx = 0; _xx<global.tilewidth; _xx++)
    {
        with instance_create(_xx*16, _yy*16, obj_tile)
        {
            type = "none"
        }
    }
}
