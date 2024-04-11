if (revealed == true)
{
    draw_sprite(spr_tiles,1,x,y)
    if (type == "none")
    {
        if (scr_return_amt_near_type("bomb") > 0)
        {
            draw_sprite_ext(spr_tilenumbers,scr_return_amt_near_type("bomb"),x,y,0.5,0.5,0,c_red,1)
        }
    }
    if (type == "bomb")
    {
        draw_sprite(spr_tiles,2,x,y)
    }
}
else
{
    draw_sprite(spr_tiles,0,x,y)
    if (marked == true)
    {
        draw_sprite(spr_xmark,0,x,y)
    }
}
