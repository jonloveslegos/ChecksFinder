if (won == true || (global.roomthiswidth >= 10 && global.roomthisheight >= 10 && global.curbombcount >= 20))
{
    won = true
    audio_play_sound(snd_digright,0,false)
    var done = false
    for (var yy = 0;yy<global.tileheight;yy++)
    {
        for (var xx = 0;xx<global.tilewidth;xx++)
        {
            if (done == false)
            {
                with (instance_position(xx*16,yy*16,obj_tile))
                {
                    if (type == "none")
                    {
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 2
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 2
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 2
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 3
                        }
                    }
                    if (type == "bomb")
                    {
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 4
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 4
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 4
                        }
                        with instance_create(x+8,y+8,obj_piece)
                        {
                            image_index = 5
                        }
                    }
                    instance_destroy(self)
                    done = true
                }
            }
        }
    }
    if (done == true)
    {
        alarm[0] = 2
    }
    else
    {
        file_text_close(file_text_open_write("victory"))
        room_goto(rm_win)
    }
}
else
{
    room_restart()
}
