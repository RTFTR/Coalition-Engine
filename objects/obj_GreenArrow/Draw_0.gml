var soul = obj_battle_soul;
var dir_e = ((mode == 2 or mode == 3) ? 45 : 0);
if id = instance_nearest(soul.x, soul.y, obj_GreenArrow) index = 4;
image_index = index + mode;
image_angle = dir + dir_e + dir_a;
len -= spd;


if mode == 1 or mode == 3
{
	if len <= 200 and !flipped
	{
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 90/spd, "dir", dir, dir - 180)
		flipped = 1;
	}
}

if global.Autoplay
	if id = instance_nearest(soul.x, soul.y, obj_GreenArrow)
		if len < 60
		{
			soul.ShieldTargetAngle = dir;
			if soul.ShieldTargetAngle < 0
				soul.ShieldTargetAngle += 360;
			soul.ShieldTargetAngle %= 360;
		}

x = lengthdir_x(len, dir + dir_e + dir_a) + soul.x;
y = lengthdir_y(len, dir + dir_e + dir_a) + soul.y;

draw_self();

