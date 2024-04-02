if (won == true || (global.roomthiswidth >= 10 && global.roomthisheight >= 10 && global.curbombcount >= 20))
{
    won = true
    audio_play_sound(snd_digright,0,false)
    var _done = false
    for (var _yy = 0;_yy<global.tileheight;yy++)
    {
        for (var _xx = 0;_xx<global.tilewidth;xx++)
        {
            if (_done == false)
            {
                with (instance_position(_xx*16,_yy*16,obj_tile))
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
	scr_updateobtains()
    room_restart()
}
