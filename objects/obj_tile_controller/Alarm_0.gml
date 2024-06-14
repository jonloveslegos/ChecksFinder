///@description: Board end
if (won == true || (global.roomthiswidth >= 10 && global.roomthisheight >= 10 && global.curbombcount >= 20))
{
    won = true
    audio_play_sound(snd_digright,0,false)
    var _done = false
    for (var _yy = 0;_yy<global.roomthisheight;_yy++)
    {
        for (var _xx = 0;_xx<global.roomthiswidth;_xx++)
        {
            if (_done == false)
            {
                with (instance_position(_xx*16+1,_yy*16+1,obj_tile))
                {
                    if (type == "none")
                    {
						scr_gen_pieces(x,y,global.tile_data.background)
                    }
                    if (type == "bomb")
                    {
                        scr_gen_pieces(x,y,global.tile_data.bomb)
                    }
                    instance_destroy(self)
                    _done = true
                }
            }
        }
    }
    if (_done == true)
    {
        alarm[0] = 2
    }
    else
    {
		var _data = [{
			cmd: "StatusUpdate",
			status: int64(30),
		}]
		scr_send_packet(json_stringify(_data))
    }
}
else
{
    room_restart()
}
