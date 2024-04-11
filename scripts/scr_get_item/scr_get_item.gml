function scr_get_item(argument0) {
	if (argument0 == "width")
	{
	    global.tilewidth = min(global.tilewidth+1,10)
	}
	if (argument0 == "height")
	{
	    global.tileheight = min(global.tileheight+1,10)
	}
	if (argument0 == "bomb")
	{
	    global.bombcount = min(global.bombcount+1,20)
	}
}
