with(oBulletParents)
	if place_meeting(x, y, other)
	{
		instance_destroy();
		instance_destroy(other);
	}

motion_blur(speed * 2, image_angle - 90);
draw_self();

show_hitbox(c_green)