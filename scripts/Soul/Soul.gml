function Battle_SoulMode(mode)
{
	obj_battle_soul.mode = mode;
}
function Battle_SetSoulPos(target_x, target_y, duration = 0, Easing = EaseLinear, delay = 0)
{
	with(obj_battle_soul)
	{
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "x", x, target_x);
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "y", y, target_y);
	}
}

