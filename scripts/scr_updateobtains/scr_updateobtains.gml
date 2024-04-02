function scr_updateobtains() {
	var filename = file_find_first("*.item",0)
	while (filename != "")
	{
	    if (!file_exists(filename+"obtain"))
	    {
	        var file = file_text_open_read(filename)
	        var read = file_text_read_string(file)
	        if (real(string_digits(read)) == 80000)
	            scr_getitem("width")
	        if (real(string_digits(read)) == 80001)
	            scr_getitem("height")
	        if (real(string_digits(read)) == 80002)
	            scr_getitem("bomb")
	        file_text_close(file)
	        file_text_close(file_text_open_write(filename+"obtain"))
	    }
	    filename = file_find_next()
	}
}
