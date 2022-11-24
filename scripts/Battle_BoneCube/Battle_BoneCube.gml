///@desc Creates a Bone Cube
///@param {Array} Position			The x and y position of the cube (Array/ Vec2)
///@param {Array} Angles			The xyz angles of the cube (Array/ Vec3)
///@param {Array} Rotate_Speeds		The angle rotations of the cube (Array/ Vec3)
///@param {real} Scales				The xyzscale of the cube
///@param {real} Anim_Time			The time of the scaling animation (Default 0 - Instant)
///@param {function} Easing			The easing of the scaling animation (Default EaseLinear)
function Battle_BoneCube(pos, ans, rots, scale, anim_time = 0, ease = EaseLinear)
{
	var inst = instance_create_depth(pos[0], pos[1], -2, oBoneCube)
	with(inst)
	{
		angles = ans;
		angleAdd = rots;
		scalex = scale[0];
		scaley = scale[1];
		scalez = scale[2];
		if anim_time
		{
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scalex", 0, scale[0]);
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scaley", 0, scale[1]);
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scalez", 0, scale[2]);
		}
	}
	return inst;
}