if (global.other_settings.enable_fishfinder) {
	if (!global.other_settings.overwrite_background) {
		global.tile_data.background.color = #0055a2
	}
	global.tile_data.bomb.tile_index = 2
	global.tile_data.bomb.piece_index = 4
	if (!global.other_settings.overwrite_tile_text) {
		global.game_color.tile_text = c_maroon
	}
}
var _cnt = 0
for (var _i = 0; _i < array_length(global.spotlist);_i++)
{
    if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5)
    {
        if (global.spotlist[_i] == 0)
        {
            _cnt++
        }
    }
}
var _bombs = 0
var _flags = 0
with(obj_tile)
{
    if (type == "bomb")
    {
        _bombs++
    }
    if (marked == true)
    {
        _flags++
    }
}
if (_bombs == 0)
{
    _bombs = min(global.roomthisbomb,((global.roomthiswidth*global.roomthisheight) div 5))
}
draw_set_halign(fa_left)
draw_sprite_ext(spr_tiles,3,8,view_get_hport(0)-150,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,view_get_hport(0)-170,string_hash_to_newline(string(_cnt)))
draw_sprite_ext(spr_tiles,4,8,view_get_hport(0)-100,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,view_get_hport(0)-120,string_hash_to_newline(string(global.tilewidth)+"/10"))
draw_sprite_ext(spr_tiles,5,8+240,view_get_hport(0)-100,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60+240,view_get_hport(0)-120,string_hash_to_newline(string(global.tileheight)+"/10"))
draw_sprite_ext(spr_tiles,6,8+240,view_get_hport(0)-150,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60+240,view_get_hport(0)-170,string_hash_to_newline(string(global.bombcount)+"/20"))
draw_sprite_ext(spr_tiles,global.tile_data.bomb.tile_index,8,view_get_hport(0)-50,3,3,0,c_white,1)
draw_set_font(fnt_main)
draw_text(60,view_get_hport(0)-70,string_hash_to_newline(string(_flags)+"/"+string(_bombs)))
