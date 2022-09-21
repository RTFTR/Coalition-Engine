///@desc Fades the screen
///@param {real} start		The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real} target	The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real} duration	The time the fader fades from start to end
///@param {real} delay		The delay for the fader to fade (Default 0)
///@param color		The color of the fader (Default c_black)
function Fader_Fade(start, target, duration, delay = 0, color = c_black)
{
	obj_global.fader_color = color;
	TweenFire(obj_global,EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
}

///@desc Blurs the screen
///@param {real} duration	The duration to blur
///@param {real} amount		The amount to blur
function Blur_Screen(duration,amount){
var shader_blur=instance_create_depth(0,0,-1000,blur_shader)
with(shader_blur)
{
	duration=duration            //sets duration
	var_blur_amount=amount       //sets blur amount
	TweenFire(id, EaseOutSine,	TWEEN_MODE_ONCE, false, 0, duration, "var_blur_amount", amount, 0)
}
return shader_blur;}

