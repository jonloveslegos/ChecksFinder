if (revealed == true && mouse_check_button(mb_left))
{
    with (instance_position(x,y-16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x,y+16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x+16,y,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x-16,y,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x+16,y+16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x+16,y-16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x-16,y+16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
    with (instance_position(x-16,y-16,obj_tile))
    {
        if (marked == false)
        {
            scr_revealtile()
        }
    }
}
else
{
    marked = !marked
    audio_play_sound(snd_digright,0,false)
}

