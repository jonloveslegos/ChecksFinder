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
    global.checksgotten = 0
    for (var _i = 0; _i < array_length(global.spotlist);_i++)
    {
        if (_i < global.tilewidth+global.tileheight+global.bombcount-5-5)
        {
            if (!file_exists("send"+string(_i+81000)))
            {
                _checksavail = _i
                global.spotlist[_i] = 0
                break
            }
            else
            {
                global.spotlist[_i] = 1
                global.checksgotten++
            }
        }
    }
    if (_checksavail > -1)
    {
        global.spotlist[_checksavail] = 1
        scr_send_item(_checksavail+81000)
        global.checksgotten++
    }
}
