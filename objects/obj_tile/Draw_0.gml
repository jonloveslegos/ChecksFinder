if (revealed == true)
{
    draw_sprite_ext(spr_tiles,0,x,y,1,1,0,#aa7a50,1)
    if (type == "none")
    {
        if (scr_return_amt_near_type("bomb") > 0)
        {
            draw_sprite_ext(spr_tilenumbers,scr_return_amt_near_type("bomb"),x,y,0.5,0.5,0,c_red,1)
        }
    }
    if (type == "bomb")
    {
        draw_sprite(spr_tiles,1,x,y)
    }
}
else
{
    draw_sprite_ext(spr_tiles,0,x,y,1,1,0,#5ac05a,1)
    if (marked == true)
    {
        draw_sprite(spr_xmark,0,x,y)
    }
}
