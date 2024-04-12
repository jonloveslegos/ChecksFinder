if (revealed == true)
{
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
    if (type == "none")
    {
        if (scr_return_amt_near_type("bomb") > 0)
        {
            draw_sprite_ext(spr_tilenumbers,scr_return_amt_near_type("bomb"),x,y,0.5,0.5,0,c_red,1)
        }
    }
    if (type == "bomb")
    {
        draw_sprite(spr_tiles,global.tile_data.bomb.tile_index,x,y)
    }
}
else
{
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
    if (marked == true)
    {
        draw_sprite(spr_xmark,0,x,y)
    }
}
