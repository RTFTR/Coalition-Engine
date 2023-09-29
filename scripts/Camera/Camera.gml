/**
	Shakes the Camera
	@param {real} Amount	The amount in pixels to shake
	@param {real} Decrease	The amount of intensity to decrease after each frame
*/
function Camera_Shake(amount, decrease = 1)
{
	with oGlobal
	{
		camera_shake_i = ceil(amount);
		camera_decrease_i = ceil(decrease);
		if camera_enable_z
		{
			camAngleXShake = amount / 2;
			camAngleYShake = -amount / 2;
		}
	}
}

/**
	Sets the scale of the Camera
	@param {real} Scale_X		The X scale of the camera
	@param {real} Scale_Y		The Y scale of the camera
	@param {real} duration		The anim duration of the scaling
	@param {function} ease		The easing of the animation
*/
function Camera_Scale(sx, sy, duration = 0, ease = EaseLinear)
{
	with oGlobal {
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_scale_x", camera_scale_x, sx, "camera_scale_y", camera_scale_y, sy);
	}
}

/**
	Sets the X and Y position of the Camera
	@param {real}				x The x position
	@param {real}				y The y position
	@param {real} duration		The anim duration of the movement
	@param {real} delay			The anim delay of the movement
	@param {function} ease		The easing of the animation
*/
function Camera_SetPos(x, y, duration, delay = 0, ease = EaseLinear)
{
	with oGlobal {
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_x", camera_x, x, "camera_y", camera_y, y);
	}
}

/**
	Rotates the camera
	@param {real} start			The start angle of the camera
	@param {real} target		The target angle of the camera
	@param {real} duration		The time taken for the camera to rotate
	@param {function} Easing	The ease of the rotation
	@param {real} delay 		The delay of the animation
*/
function Camera_RotateTo(start, target, duration, ease = EaseLinear, delay = 0)
{
	TweenFire(oGlobal, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_angle", start, target);
}

