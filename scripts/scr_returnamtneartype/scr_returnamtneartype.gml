/// @description scr_returnamtneartype(type)
/// @param type
function scr_returnamtneartype(argument0) {
	var amtbmb = 0
	with (instance_position(x,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x-16,y,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x+16,y,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x-16,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x-16,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x+16,y-16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	with (instance_position(x+16,y+16,obj_tile))
	{
	    if (type == argument0)
	    {
	        amtbmb++
	    }
	}
	return amtbmb
}
