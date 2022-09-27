///@desc Fades the screen
///@param {real}  start				The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  duration			The time the fader fades from start to end
///@param {real}  delay				The delay for the fader to fade (Default 0)
///@param {Constant.Color} color	The color of the fader (Default c_black)
function Fader_Fade(start, target, duration, delay = 0, color = c_black)
{
	obj_global.fader_color = color;
	TweenFire(obj_global,EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
}

///@desc Blurs the screen
///@param {real} duration	The duration to blur
///@param {real} amount		The amount to blur
function Blur_Screen(duration, amount)
{
var shader_blur=instance_create_depth(0,0,-1000,blur_shader)
with(shader_blur)
{
	duration=duration            //sets duration
	var_blur_amount=amount       //sets blur amount
	TweenFire(id, EaseOutSine,	TWEEN_MODE_ONCE, false, 0, duration, "var_blur_amount", amount, 0)
}
//var a = Effect_Shader(shd_GaussianBlur, "size", amount)
//with(a)
//{
//	duration = duration;
//}
return shader_blur;
}

///@desc Creates a motion blur of a sprite
///@param length	The length of the blur
///@param direction	The direction of the blur
function motion_blur(length,direction){
    if (length > 0) {
		var step,dir,px,py,a;
        step = 3;
        dir = degtorad(direction);
        px = cos(dir);
        py = -sin(dir);
 
        a = image_alpha/(length/step);
        if (a >= 1) {
            draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,
                image_yscale,image_angle,image_blend,image_alpha);
            a /= 2;
        }
 
        for(var i=length;i>=0;i-=step) {
            draw_sprite_ext(sprite_index,image_index,x+(px*i),y+(py*i),
                image_xscale,image_yscale,image_angle,image_blend,a);
        }
    } else {    
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,
            image_yscale,image_angle,image_blend,image_alpha);
    }
    return 0;
}

///@desc Creates a motion blur of a sprite
///@param sprite	The sprite to blur
///@param subimg	The image index of the sprite
///@param x			The x position
///@param y			The y position
///@param xscale	The xscale of the sprite
///@param yscale	The yscale of the sprite
///@param angle		The angle fo the sprite
///@param blend		The image blend of the sprite
///@param alpha		The alpha of the sprite
///@param length	The length of the blur
///@param direction	The direction of the blur
function motion_blur_ext(sprite,subimg,xx,yy,xscale,yscale,angle,blend,alpha,length,direction){
    if (length > 0) {
		var step,dir,px,py,a;
        step = 3;
        dir = degtorad(direction);
        px = cos(dir);
        py = -sin(dir);
 
        a = image_alpha/(length/step);
        if (a >= 1) {
            draw_sprite_ext(sprite,subimg,xx,yy,xscale,
                yscale,angle,blend,alpha);
            a /= 2;
        }
 
        for(var i=length;i>=0;i-=step) {
            draw_sprite_ext(sprite,subimg,xx+(px*i),yy+(py*i),
                xscale,yscale,angle,blend,a);
        }
    } else {    
        draw_sprite_ext(sprite,subimg,xx,yy,xscale,
            yscale,angle,blend,alpha);
    }
    return 0;
}

///@desc Rotates the camera
///@param {real} target		The target angle of the camera
///@param {real} duration	The time taken for the camera to rotate
///@param {function} Easing	The ease of the rotation
function Camera_RotateTo(target, duration, ease = EaseLinear)
{
	TweenFire(obj_global, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_angle", obj_global.camera_angle, target);
}

///@desc Creates the effect with the shader given, if the shader has multiple params do Effect_Shader(shader, param name, param val, param name, param val...)
///@param {Assets.GMShader} Shader	The shader to use
///@param {string} Parameter_Name	The name of the uniform parameter
///@param {real} Parameter_Value	The value of the uniform parameter
function Effect_Shader()
{
	var shd = argument[0];
	var param = ["", 1];
	for(var i = 1; i < argument_count; i+=2)
	{
		param[i - 1] = argument[i];
		param[i] = argument[i + 1];
	}
	var eff = instance_create_depth(0,0,-100000, shaderEffect)
	with(eff)
	{
		effect_shader = shd;
		effect_param = param;
	}
	return eff
}

///@desc Sets the uniform vars of the given shader, if drawn using Effect_Shader() (1 VECTOR ONLY)
///@param {Assets.GMShader} Shader	The name of the shader to apply to
///@param {string} Param_Name	The name of the uniform variable
///@param {string} Param_value	The value of the uniform variable
function Effect_SetParam()
{
	with(shaderEffect)
	{
		if effect_shader = argument[0]
		{
			for(var i = 1; i < argument_count; i += 2)
			{
				effect_param = [argument[i], argument[i + 1]];
			}
		}
	}
}

