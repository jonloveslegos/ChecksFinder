global.fn_is_bomb = function(_tile) {
	with(_tile) {
		return type == "bomb"
	}
}

function scr_count_surrounding(_tile, _tile_fn) {
	var _count = 0
	with(_tile) {
		//instance_position is usually used for collision, so edge points can apply to multiple tiles -
		//which means we should check non-edge coordinates
		if (_tile_fn(instance_position(x+2,y-14,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+2,y+18,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-14,y+2,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+18,y+2,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-14,y-14,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-14,y+18,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+18,y-14,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+18,y+18,obj_tile)))
		{
		    _count++
		}
	}
	return _count
}
