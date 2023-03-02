with(oBulletParents)
	if place_meeting(x, y, other)
	{
		instance_destroy();
		instance_destroy(other);
	}

TrailStep(10);

if check_outside() instance_destroy();