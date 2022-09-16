function Fader_Fade(start, target, duration, delay = 0, color = c_black)
{
	obj_global.fader_color = color;
	TweenFire(obj_global,EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
}

function Blur_Screen(duration,amount){
var shader_blur=instance_create_depth(0,0,-1000,blur_shader)
with(shader_blur)
{
	duration=duration            //sets duration
	var_blur_amount=amount       //sets blur amount
	TweenFire(id, EaseOutSine,	TWEEN_MODE_ONCE, false, 0, duration, "var_blur_amount", amount, 0)
}
return shader_blur;}

