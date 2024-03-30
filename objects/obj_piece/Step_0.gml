y += yspd
yspd += 1
x += xspd
if (y > room_height)
{
    instance_destroy(self)
}

