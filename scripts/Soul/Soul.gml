///@desc Sets the Mode of the Soul (Macros are given, i.e. SOUL_MODE.RED)
///@param {real} mode	The mode of the soul to set to
///@param {bool} effect	Whether to create the soul effect or not (Default True)
function Battle_SoulMode(soul_mode, effect = true)
{
	with(obj_battle_soul)
	{
		image_angle = 0;
		if soul_mode = SOUL_MODE.RED image_blend = c_red;
		if soul_mode = SOUL_MODE.BLUE image_blend = c_blue;
		if soul_mode = SOUL_MODE.ORANGE image_blend = c_orange;
		if soul_mode = SOUL_MODE.YELLOW {image_blend = c_yellow; image_angle = 180;}
		if soul_mode = SOUL_MODE.GREEN image_blend = c_lime;
		if soul_mode = SOUL_MODE.PURPLE image_blend = c_purple;
		if soul_mode = SOUL_MODE.CYAN image_blend = c_aqua;
		mode = soul_mode;
		effect_xscale = 1;
		effect_yscale = 1;
		effect_alpha = 1;
		effect_angle = image_angle;
		effect_x = x;
		effect_y = y;
		alarm[0] = effect
	}
}

///@desc Sets the position of the soul, can choose to animate the position
///@param {real} target_x	The target X position
///@param {real} target_y	The target Y position
///@param {real} duration	The duration of the Anim (Default 0, which is instant movement)
///@param {function} Easing	The Tween Ease of the Animation (Use TweenGMS structs, i.e. EaseOutQuad, Default EaseLinear)
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

