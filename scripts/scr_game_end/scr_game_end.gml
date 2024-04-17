// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_game_end(){
	var _filename = file_find_first("*",0)
	while (_filename != "")
	{
	    if (string_count("obtain",_filename) > 0)
	    {
	        file_delete(_filename)
	    }
	    _filename = file_find_next()
	}
	file_find_close();
	var _file = file_find_first("*", 0);
	while (_file != "")
	{
	    if (string_count("send",_file) > 0)
	        file_delete(_file)
	    _file = file_find_next();
	}
	file_find_close();
}