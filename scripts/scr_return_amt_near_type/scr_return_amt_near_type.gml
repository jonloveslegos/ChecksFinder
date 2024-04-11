/// @description scr_returnamtneartype(type)
/// @param type
function scr_return_amt_near_type(argument0) {
	var _amtbmb = 0
	with (instance_position(x,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x-16,y,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x+16,y,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x-16,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x-16,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x+16,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	with (instance_position(x+16,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        _amtbmb++
	    }
	}
	return _amtbmb
}
