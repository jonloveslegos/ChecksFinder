        with (instance_position(x,y-16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x,y+16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x-16,y,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x+16,y,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x-16,y-16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x-16,y+16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x+16,y-16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
        with (instance_position(x+16,y+16,obj_tile))
        {
            if (type == "none" && revealed == false)
            {
                revealed = true
                if (scr_returnamtneartype("bomb") == 0)
                {
                    scr_uncoversurrounding()
                }
            }
        }
