global.fn_is_bomb = function(_tile) {
	with(_tile) {
		return type == "bomb"
	}
}

function scr_count_surrounding(_tile, _tile_fn) {
	var _count = 0
	with(_tile) {
		//these functions are usually used for collision, so edge points can apply to multiple tiles -
		//which means we should check non-edge coordinates
		if (_tile_fn(instance_position(x+1,y-15,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+1,y+17,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-15,y+1,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+17,y+1,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-15,y-15,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x-15,y+17,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+17,y-15,obj_tile)))
		{
		    _count++
		}
		if (_tile_fn(instance_position(x+17,y+17,obj_tile)))
		{
		    _count++
		}
	}
	return _count
}
