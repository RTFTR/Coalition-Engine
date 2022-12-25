///@desc Sets the Mode of the Soul (Macros are given, i.e. SOUL_MODE.RED)
///@param {real} mode	The mode of the soul to set to
///@param {bool} effect	Whether to create the soul effect or not (Default True)
function Battle_SoulMode(soul_mode, effect = true)
{
	with oSoul
	{
		dir = DIR.DOWN;
		draw_angle = 0;
		image_angle = 0;
		switch soul_mode
		{
			case SOUL_MODE.RED:			Blend = c_red;		break
			case SOUL_MODE.BLUE:		Blend = c_blue;		break
			case SOUL_MODE.ORANGE:		Blend = c_orange;	break
			case SOUL_MODE.YELLOW:		{Blend = c_yellow; draw_angle = 180;} break
			case SOUL_MODE.GREEN:		Blend = c_lime;		break
			case SOUL_MODE.PURPLE:		Blend = c_purple;	break
			case SOUL_MODE.CYAN:		Blend = c_aqua;		break
		}
		ChangeColor();
		mode = soul_mode;
		alarm[0] = effect;
	}
}

///@desc Sets the position of the soul, can choose to animate the position
///@param {real} target_x	The target X position
///@param {real} target_y	The target Y position
///@param {real} duration	The duration of the Anim (Default 0, which is instant movement)
///@param {function} Easing	The Tween Ease of the Animation (Use TweenGMS structs, i.e. EaseOutQuad, Default EaseLinear)
///@param {real} delay		The delay of executing the Anim (Default 0)
function Battle_SetSoulPos(target_x, target_y, duration = 0, Easing = EaseLinear, delay = 0)
{
	with oSoul {
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "x", x, target_x);
		TweenFire(id, Easing, TWEEN_MODE_ONCE, false, delay, duration, "y", y, target_y);
	}
}

///@desc Return whether is soul moving or not
function IsSoulMoving() {
	return (floor(oSoul.x) != floor(oSoul.xprevious)
			or floor(oSoul.y) != floor(oSoul.yprevious));
}

