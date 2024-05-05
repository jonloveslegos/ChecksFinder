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
		var _payload = "[{\"cmd\": \"StatusUpdate\", \"status\": 30}]"
		var _temp_buffer = buffer_create(0, buffer_grow, 1)
		buffer_seek(_temp_buffer, buffer_seek_start, 0)
		buffer_write(_temp_buffer, buffer_string, _payload)
		show_message(buffer_peek(_temp_buffer, 0, buffer_string))
		network_send_raw(global.client, _temp_buffer, string_length(_payload), network_send_text)
		buffer_delete(_temp_buffer)
        room_goto(rm_win)
    }
}
else
{
    room_restart()
}
