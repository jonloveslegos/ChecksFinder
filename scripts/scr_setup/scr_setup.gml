function scr_setup() {
	global.bombcount = 5
	global.tilewidth = 5
	global.tileheight = 5
	global.checksgotten = 0
	global.spotlist = undefined
	draw_set_colour(c_white);
	for (var i = 0; i < 25; i++)
	{
	    global.spotlist[i] = 0
	}
	var file = file_find_first("*", 0);
	while (file != "")
	{
	    if (string_count("send",file) > 0)
	        file_delete(file)
	    file = file_find_next();
	}
	file_find_close();



}
