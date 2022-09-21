///@desc Sets the Mode of the Soul (Macros are given, i.e. SOUL_MODE.RED)
///@param {real} mode The mode of the soul to set to
function Battle_SoulMode(mode)
{
	obj_battle_soul.mode = mode;
}

///@desc Sets the position of the soul, can choose to animate the position
///@param {real} target_x	The target X position
///@param {real} target_y	The target Y position
///@param {real} duration	The duration of the Anim (Default 0, which is instant movement)
///@param {struct} Easing	The Tween Ease of the Animation (Use TweenGMS structs, i.e. EaseOutQuad, Default EaseLinear)
///@param {real} delay		The delay of executing the Anim (Default 0)
///@self
function Battle_SetSoulPos(target_x, target_y, duration = 0, Easing = EaseLinear, delay = 0)
{
	with(obj_battle_soul)
	{
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "x", x, target_x);
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "y", y, target_y);
	}
}

