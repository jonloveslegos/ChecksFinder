var cnt = 0
for (var i = 0; i < array_length(global.spotlist);i++)
{
    if (i < global.tilewidth+global.tileheight+global.bombcount-5-5)
    {
        if (global.spotlist[i] == 0 && !file_exists("send"+string(i+81000)))
        {
            cnt++
        }
    }
}
var bombs = 0
var flags = 0
with(obj_tile)
{
    if (type == "bomb")
    {
        bombs++
    }
    if (marked == true)
    {
        flags++
    }
}
if (bombs == 0)
{
    bombs = min(global.roomthisbomb,((global.roomthiswidth*global.roomthisheight) div 5))
}
draw_set_halign(fa_left)
draw_sprite_ext(spr_tiles,3,8,__view_get( e__VW.HPort, 0 )-150,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,__view_get( e__VW.HPort, 0 )-170,string_hash_to_newline(string(cnt)))
draw_sprite_ext(spr_tiles,4,8,__view_get( e__VW.HPort, 0 )-100,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,__view_get( e__VW.HPort, 0 )-120,string_hash_to_newline(string(global.tilewidth)+"/10"))
draw_sprite_ext(spr_tiles,5,8+240,__view_get( e__VW.HPort, 0 )-100,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60+240,__view_get( e__VW.HPort, 0 )-120,string_hash_to_newline(string(global.tileheight)+"/10"))
draw_sprite_ext(spr_tiles,6,8+240,__view_get( e__VW.HPort, 0 )-150,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60+240,__view_get( e__VW.HPort, 0 )-170,string_hash_to_newline(string(global.bombcount)+"/20"))
draw_sprite_ext(spr_tiles,2,8,__view_get( e__VW.HPort, 0 )-50,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,__view_get( e__VW.HPort, 0 )-70,string_hash_to_newline(string(flags)+"/"+string(bombs)))
