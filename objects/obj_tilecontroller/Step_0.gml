var ended = true
with (obj_tile)
{
    if (type != "bomb" && revealed == false)
    {
        ended = false
    }
}
if (global.canclick == true && ended == true && alarm[0] <= 0)
{
    alarm[0] = 30
    audio_play_sound(snd_win,0,false)
    with(obj_tile)
    {
        revealed = true
    }
    var amt = 20-5+10-5+10-5
    var checksavail = -1
    global.checksgotten = 0
    for (var i = 0; i < array_length(global.spotlist);i++)
    {
        if (i < global.tilewidth+global.tileheight+global.bombcount-5-5)
        {
            if (!file_exists("send"+string(i+81000)))
            {
                checksavail = i
                global.spotlist[i] = 0
                break
            }
            else
            {
                global.spotlist[i] = 1
                global.checksgotten++
            }
        }
    }
    if (checksavail > -1)
    {
        global.spotlist[checksavail] = 1
        scr_senditem(checksavail+81000)
        global.checksgotten++
    }
}
