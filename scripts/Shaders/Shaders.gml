//All shader related functions goes here
/**
	Creates the effect with the shader given
	@param {Asset.GMShader} Shader	The shader to use
	@param {array} Parameter_Values	The name (in string) and value of the uniform parameter ([name, [values]])
	@param {real} duration The duration of the shader
*/
function Effect_Shader(shd, uniforms, duration = -1)
{
	var eff = instance_create_depth(0, 0, -100000, shaderEffect);
	with eff
	{
		duration = duration;
		effect_shader = shd;
		array_push(effect_param, uniforms);
	}
	return eff;
}

///@desc Sets the uniform vars of the given shader, if drawn using Effect_Shader()
///@param {any} Shader	The name of the shader to apply to or a specific shader effect instance
///@param {array} Param_values	The name (in string) and values of the uniform variable ([name, [value]])
function Effect_SetParam(ID, name, val)
{
	var ID_type = asset_get_type(string(ID));
	if ID_type == asset_shader
	{
		with shaderEffect
		{
			if effect_shader == ID
			{
				var i = 0, n = array_length(effect_param);
				repeat n
				{
					if effect_param[i][0] == name
					{
						effect_param[i][1] = val;
						return
					}
					else i += 2;
				}
				//If not set before
				array_push(effect_param, [name, val]);
			}
		}
	}
	else if ID_type == asset_object
	{
		with ID
		{
			var i = 0, n = array_length(effect_param);
			repeat n
			{
				if effect_param[i][0] == name
				{
					effect_param[i][1] = val;
					return
				}
				else i += 2;
			}
			//If not set before
			array_push(effect_param, [name, val]);
		}
	}
}

///@desc Blurs the screen
///@param {real} duration	The duration to blur
///@param {real} amount		The amount to blur
function Blur_Screen(duration, amount)
{
	var shader_blur = instance_create_depth(0, 0, -1000, blur_shader);
	with shader_blur
	{
		id.duration = duration;            //sets duration
		var_blur_amount = amount;       //sets blur amount
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, duration, "var_blur_amount", amount, 0);
	}
	return shader_blur;
}