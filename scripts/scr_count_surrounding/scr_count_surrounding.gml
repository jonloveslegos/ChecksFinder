global.fn_is_bomb = function(_tile) {
	with(_tile) {
		return type == "bomb"
	}
}

function scr_count_surrounding(_tile, _tile_fn) {
	var _count = 0
	with(_tile) {
		if (_tile_fn(instance_position(x,y-16,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x,y+16,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-16,y,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+16,y,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-16,y-16,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-16,y+16,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+16,y-16,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+16,y+16,obj_tile)))
		{
		    _count++
		}
	}
	return _count
}
