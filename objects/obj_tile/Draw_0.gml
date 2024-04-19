if (revealed == true)
{
	shader_set(sh_cond);
	draw_sprite_ext(
		spr_tiles,
		global.tile_data.background.tile_index,
		x,
		y,
		1,
		1,
		0,
		global.tile_data.background.color,
		1
	)
	shader_reset();
    if (type == "none")
    {
        if (scr_count_surrounding(self,global.fn_is_bomb) > 0)
        {
            draw_sprite_ext(
				spr_tilenumbers,
				scr_count_surrounding(self,global.fn_is_bomb),
				x,
				y,
				0.5,
				0.5,
				0,
				global.game_color.tile_text,
				1
			)
        }
    }
    if (type == "bomb")
    {
        draw_sprite(spr_tiles,global.tile_data.bomb.tile_index,x,y)
    }
}
else
{
	shader_set(sh_cond);
    draw_sprite_ext(
		spr_tiles,
		global.tile_data.foreground.tile_index,
		x,
		y,
		1,
		1,
		0,
		global.tile_data.foreground.color,
		1
	)
	shader_reset();
    if (marked == true)
    {
        draw_sprite(spr_xmark,0,x,y)
    }
}
