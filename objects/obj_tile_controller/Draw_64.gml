if (global.other_settings.enable_fishfinder) {
	if (!global.other_settings.overwrite_background) {
		global.tile_data.background.color = #0055a2
	}
	global.tile_data.bomb.tile_index = 2
	global.tile_data.bomb.piece_index = 4
	if (!global.other_settings.overwrite_tile_text) {
		global.game_color.tile_text = c_maroon
	}
} else {
	global.tile_data.background.color = global.custom_defaults.tile_data.background.color
	global.tile_data.bomb.tile_index = global.custom_defaults.tile_data.bomb.tile_index
	global.tile_data.bomb.piece_index = global.custom_defaults.tile_data.bomb.piece_index
	global.game_color.tile_text = global.custom_defaults.game_color.tile_text
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
draw_set_font(fnt_main)
draw_set_colour(global.game_color.ui_text)
draw_sprite_ext(spr_tiles,3,8,view_get_hport(0)-150,3,3,0,c_white,1)
draw_text_transformed(60,view_get_hport(0)-165,string_hash_to_newline(string(global.roomthischeck)), 4.9, 4.9, 0)
draw_sprite_ext(spr_tiles,4,8,view_get_hport(0)-100,3,3,0,c_white,1)
draw_text_transformed(60,view_get_hport(0)-115,string_hash_to_newline(string(global.tilewidth)+"/10"), 4.9, 4.9, 0)
draw_sprite_ext(spr_tiles,5,8+240,view_get_hport(0)-100,3,3,0,c_white,1)
draw_text_transformed(60+240,view_get_hport(0)-115,string_hash_to_newline(string(global.tileheight)+"/10"), 4.9, 4.9, 0)
draw_sprite_ext(spr_tiles,6,8+240,view_get_hport(0)-150,3,3,0,c_white,1)
draw_text_transformed(60+240,view_get_hport(0)-165,string_hash_to_newline(string(global.bombcount)+"/20"), 4.9, 4.9, 0)
draw_sprite_ext(spr_tiles,global.tile_data.bomb.tile_index,8,view_get_hport(0)-50,3,3,0,c_white,1)
draw_text_transformed(60,view_get_hport(0)-65,string_hash_to_newline(string(_flags)+"/"+string(_bombs)), 4.9, 4.9, 0)
