function scr_hidden_string(_str){
	return string_repeat("*",string_length(_str))
}

// https://gmlscripts.com/script/unix_timestamp.html
function scr_unix_timestamp(datetime = date_current_datetime()) {
	var epoch = floor(date_create_datetime(1970, 1, 1, 0, 0, 0));
	var time = floor(date_second_span(epoch, datetime));
	return time;
}
