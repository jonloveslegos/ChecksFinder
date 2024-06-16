function scr_array_count(_arr, _item) {
	var _count = 0
	for (var _i = 0; _i < array_length(_arr); _i++) {
		if (_arr[_i] == _item) {
			_count++
		}
	}
	return _count
}

function scr_get_item(_type, _index) {
	while (array_length(global.item_list) > _index) {
		array_pop(global.item_list)
	}
	array_push(global.item_list, _type)
	if (_type == "width")
	{
	    global.tilewidth = min(5+scr_array_count(global.item_list, _type),10)
	}
	if (_type == "height")
	{
	    global.tileheight = min(5+scr_array_count(global.item_list, _type),10)
	}
	if (_type == "bomb")
	{
	    global.bombcount = min(5+scr_array_count(global.item_list, _type),20)
	}
}
