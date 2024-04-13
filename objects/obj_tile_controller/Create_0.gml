layer_background_blend(layer_background_get_id(layer_get_id("Colour_main")), global.game_color.ui_background)
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
        with instance_create_layer(_xx*16, _yy*16, "Main", obj_tile)
        {
            type = "none"
        }
    }
}
