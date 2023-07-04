with(obj_ParentBullet)
{
	if place_meeting(x, y, other)
	{
		instance_destroy();
		instance_destroy(other);
	}
}

instance_trail_create(10);

if check_outside() instance_destroy();