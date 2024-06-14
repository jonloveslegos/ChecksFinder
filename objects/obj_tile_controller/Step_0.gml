var _ended = true
with (obj_tile)
{
    if (type != "bomb" && revealed == false)
    {
        _ended = false
    }
}
if (global.canclick && _ended && alarm[0] <= 0)
{
    alarm[0] = 30
    audio_play_sound(snd_win,0,false)
    with(obj_tile)
    {
        revealed = true
    }
    var _checksavail = -1
    for (var _i = 0; _i < array_length(global.spotlist);_i++)
    {
        if (_i < global.roomthiswidth+global.roomthisheight+global.roomthisbomb-5-5)
        {
            if (array_contains(global.missing_locations, _i+81000))
            {
                _checksavail = _i
                global.spotlist[_i] = 0
                break
            }
            else
            {
                global.spotlist[_i] = 1
            }
        }
    }
    if (_checksavail > -1)
    {
		var _check = _checksavail+81000
		var _payload = "[{\"cmd\":\"LocationChecks\",\"locations\":["+string(_check)+"]}]"
        scr_send_packet(_payload)
		global.spotlist[_checksavail] = 1
		array_delete(global.missing_locations, array_get_index(global.missing_locations, _check), 1)
    }
}
