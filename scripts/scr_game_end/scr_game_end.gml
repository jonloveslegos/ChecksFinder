function scr_game_end(){
	var _filename = file_find_first(game_save_id + "*",0)
	while (_filename != "")
	{
	    if (string_count("obtain",_filename) > 0 || string_count("send",_filename) > 0)
	    {
	        file_delete(game_save_id + _filename)
		}
	    _filename = file_find_next()
	}
	file_find_close();
}