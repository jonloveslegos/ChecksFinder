global.layout_update_required = scr_is_layout_update_required() || global.layout_update_required
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
		if (type == "bomb") {
			marked = true
		}
    }
    var _checksavail = -1
	var _data = [{
		cmd: "LocationChecks",
		locations: []
	}]
    for (var _i = 0; _i < array_length(global.spotlist);_i++)
    {
        if (_i < global.roomthiswidth+global.roomthisheight+global.roomthisbomb-5-5)
        {
            if (array_contains(global.missing_locations, _i+81000))
            {
                _checksavail = _i
                global.spotlist[_i] = int64(0)
                break
            }
            else
            {
                global.spotlist[_i] = int64(_i+81000)
				//ignore warning, it's wrong
				_data[0].locations[_i] = int64(global.spotlist[_i])
            }
        }
    }
    if (_checksavail > -1)
    {
		var _check = _checksavail+81000
		//ignore warning, it's wrong
		_data[0].locations[_checksavail] = int64(_check)
        scr_send_packet(_data)
		global.spotlist[_checksavail] = int64(_check)
		array_delete(global.missing_locations, array_get_index(global.missing_locations, _check), 1)
    }
}
scr_ap_update_checks()
global.roomthischeck = 0
for (var _i = 0; _i < array_length(global.spotlist);_i++)
{
    if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5)
    {
        if (global.spotlist[_i] == 0)
        {
            global.roomthischeck++
        }
    }
}
