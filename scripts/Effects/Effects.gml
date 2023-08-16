///@desc Fades the screen
///@param {real}  start				The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  duration			The time the fader fades from start to end
///@param {real}  delay				The delay for the fader to fade (Default 0)
///@param {Constant.Color} color	The color of the fader (Default c_black)
function Fader_Fade(start, target, duration, delay = 0, color = c_black)
{
	oGlobal.fader_color = color;
	TweenFire(oGlobal, EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
}

function Fade_Out(mode = FADE.CIRCLE, duration = 30, delay = 60)
{
	with oGlobal
	{
		Fade.Activate[mode, 0] = true;
		Fade.Activate[mode, 1] = duration;
		Fade.Activate[mode, 2] = delay;
	}
}

///@desc Blurs the screen
///@param {real} duration	The duration to blur
///@param {real} amount		The amount to blur
function Blur_Screen(duration, amount)
{
	var shader_blur = instance_create_depth(0, 0, -1000, blur_shader)
	with shader_blur
	{
		duration = duration            //sets duration
		var_blur_amount = amount       //sets blur amount
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, duration, "var_blur_amount", amount, 0)
	}
	return shader_blur;
}

///@desc Creates a motion blur of a sprite
///@param {real} length	The length of the blur
///@param {real} direction	The direction of the blur
function motion_blur(length, direction){
    if (length > 0) {
		var step, dir, px, py, a;
        step = 3;
        px = dcos(direction);
        py = -dsin(direction);
 
        a = image_alpha / (length / step);
        if (a >= 1) {
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale,
                image_yscale, image_angle, image_blend, image_alpha);
            a /= 2;
        }
 
        for(var i = length; i >= 0; i -= step) {
            draw_sprite_ext(sprite_index, image_index, x + (px * i), y + (py * i),
                image_xscale, image_yscale, image_angle, image_blend, a);
        }
    } else {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale,
                image_yscale, image_angle, image_blend, image_alpha);
    }
}

///@desc Creates a motion blur of a sprite
///@param {real} sprite				The sprite to blur
///@param {real} subimg				The image index of the sprite
///@param {real} x					The x position
///@param {real} y					The y position
///@param {real} xscale				The xscale of the sprite
///@param {real} yscale				The yscale of the sprite
///@param {real} angle				The angle fo the sprite
///@param {Constant.color} blend	The image blend of the sprite
///@param {real} alpha				The alpha of the sprite
///@param {real} length	The			length of the blur
///@param {real} direction			The direction of the blur
function motion_blur_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha, length, direction) {
    if (length > 0) {
		var step, dir, px, py, a;
        step = 3;
        px = dcos(direction);
        py = -dsin(direction);
 
        a = image_alpha / (length / step);
        if (a >= 1) {
            draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha);
            a /= 2;
        }
 
        for(var i = length; i >= 0; i -= step) {
            draw_sprite_ext(sprite, subimg, xx + (px * i), yy + (py * i), xscale, yscale, angle, blend, a);
        }
    } else {
        draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha);
    }
}

///@desc Rotates the camera
///@param {real} start		The start angle of the camera
///@param {real} target		The target angle of the camera
///@param {real} duration	The time taken for the camera to rotate
///@param {function} Easing	The ease of the rotation
///@param {real} delay 		The delay of the animation
function Camera_RotateTo(start, target, duration, ease = EaseLinear, delay = 0)
{
	TweenFire(oGlobal, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_angle", start, target);
}

///@desc Creates the effect with the shader given
///@param {Asset.GMShader} Shader	The shader to use
///@param {array} Parameter_Values	The name (in string) and value of the uniform parameter ([name, [values]])
///@param {real} duration The duration of the shader
function Effect_Shader(shd, uniforms, duration = -1)
{
	var eff = instance_create_depth(0, 0, -100000, shaderEffect)
	with(eff)
	{
		duration = duration;
		effect_shader = shd;
		array_push(effect_param, uniforms);
	}
	return eff
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
				var i = 0;
				repeat array_length(effect_param)
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
			var i = 0;
			repeat array_length(effect_param)
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

///@desc Shakes the Camera
///@param {real} Amount		The amount in pixels to shake
///@param {real} Decrease	The amount of intensity to decrease after each frame
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

///@desc Sets the scale of the Camera
///@param {real} Scale_X		The X scale of the camera
///@param {real} Scale_Y		The Y scale of the camera
///@param {real} duration		The anim duration of the scaling
///@param {function} ease		The easing of the animation
function Camera_Scale(sx, sy, duration = 0, ease = EaseLinear)
{
	with oGlobal {
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_scale_x", camera_scale_x, sx);
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_scale_y", camera_scale_y, sy);
	}
}

///@desc Sets the X and Y position of the Camera
///@param {real}				x The x position
///@param {real}				y The y position
///@param {real} duration		The anim duration of the movement
///@param {real} delay			The anim delay of the movement
///@param {function} ease		The easing of the animation
function Camera_SetPos(x, y, duration, delay = 0, ease = EaseLinear)
{
	with oGlobal {
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_x", camera_x, x);
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_y", camera_y, y);
	}
}

///@desc Draws a outline of a cube
///@param {real} x					The x position of the cube
///@param {real} y					The y position of the cube
///@param {real} size				The size of the cube
///@param {real} horizontal_angle	The Horizontal Angle of the cube
///@param {real} vertical_angle		The Vertical Angle of the cube
///@param {Constant.Color} color	The Color of the cube
function draw_cube_outline(_draw_x,_draw_y,_size,_point_h,_point_v,_colour) {
	
	var nodes = [[-1, -1, -1], [-1, -1, 1], [-1, 1, -1], [-1, 1, 1],
    [1, -1, -1], [1, -1, 1], [1, 1, -1], [1, 1, 1]];
 
	var edges = [[0, 1], [1, 3], [3, 2], [2, 0], [4, 5], [5, 7], [7, 6],
	[6, 4], [0, 4], [1, 5], [2, 6], [3, 7]];

	_point_h *= pi;
	_point_v *= pi;

	var sinX = sin(_point_h);
	var cosX = cos(_point_h);
 
	var sinY = sin(_point_v);
	var cosY = cos(_point_v);
	
	var number_of_nodes = array_length(nodes);
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i];

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node;
	};

	draw_set_colour(_colour);

	var number_of_edges = array_length(edges);
	for (var i = 0; i < number_of_edges; ++i) {
	
		var edge = edges[i];
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line(_draw_x + (p1[0] * _size), _draw_y + (p1[1] * _size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size));
	};

}

///@desc Draws a outline with given width of a cube
///@param {real} x					The x position of the cube
///@param {real} y					The y position of the cube
///@param {real} size				The size of the cube
///@param {real} horizontal_angle	The Horizontal Angle of the cube
///@param {real} vertical_angle		The Vertical Angle of the cube
///@param {Constant.Color} color	The Color of the cube
///@param {real} width				The Width of the outline of the cube
///@param {bool} circle_on_edge		Whether the corners of the cube are round
function draw_cube_width(_draw_x ,_draw_y, _size, _point_h, _point_v, _colour, _width, _edge_circ = true) {
	
	var nodes = [[-1, -1, -1], [-1, -1, 1], [-1, 1, -1], [-1, 1, 1],
    [1, -1, -1], [1, -1, 1], [1, 1, -1], [1, 1, 1]];
 
	var edges = [[0, 1], [1, 3], [3, 2], [2, 0], [4, 5], [5, 7], [7, 6],
	[6, 4], [0, 4], [1, 5], [2, 6], [3, 7]];

	_point_h *= pi;
	_point_v *= pi;

	var sinX = sin(_point_h);
	var cosX = cos(_point_h);
 
	var sinY = sin(_point_v);
	var cosY = cos(_point_v);
	
	var number_of_nodes = array_length(nodes);
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i];

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node;
	};

	draw_set_colour(_colour);

	var number_of_edges = array_length(edges);
	for (var i = 0; i < number_of_edges; ++i) {
	
		var edge = edges[i];
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line_width(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size),_width);
		
		if _edge_circ
			draw_circle(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_width/2,false);
	};
	
}

//function draw_circle_width(x, y, radius = 100, thickness = 4, segments = 20, color = c_white)
//{
//	var jadd = 360/segments;
//	draw_set_color(color);
//	draw_primitive_begin(pr_trianglestrip);
//	for (var j = 0; j <= 360; j+=jadd)
//	{
//	    draw_vertex(x + lengthdir_x(radius, j), y + lengthdir_y(radius, j));
//		radius += thickness;
//	    draw_vertex(x + lengthdir_x(radius, j), y + lengthdir_y(radius, j));
//		radius -= thickness;
//	}
//	draw_primitive_end();
//}

//@desc Creates a trail of the object
///@param {real} duration		The duration of the effect
function TrailStep(duration = 30) {
	part_system_depth(global.TrailS, depth + 1);
	part_type_sprite(global.TrailP, sprite_index, 0, 0, 0);
	part_type_life(global.TrailP, duration, duration);
	part_type_orientation(global.TrailP, image_angle, image_angle, 0, 0, 0);
	part_particles_create_color(global.TrailS, x, y, global.TrailP, image_blend, 1);
}

/**
	@desc Creates a trail of given sprite and params
*/
function TrailEffect(Duration, Sprite = sprite_index, Subimg = image_index, X = x, Y = y, Xscale = image_xscale,
					Yscale = image_yscale, Rot = image_angle, Col = image_blend, Alpha = image_alpha)
{
	with instance_create_depth(X, Y, depth + 1, oEffect)
	{
		sprite = Sprite;
		subimg = Subimg;
		xscale = Xscale;
		yscale = Yscale;
		rot = Rot;
		col = Col;
		alpha = Alpha;
		duration = Duration;
	}
}

function draw_circular_bar(x ,y ,value, max, colour, radius, transparency, width)
{
	if (value > 0) { // no point even running if there is nothing to display (also stops /0
	    var i, len, tx, ty, val;
    
	    var numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
	    var sizeofsection = 360/numberofsections
    
	    val = (value/max) * numberofsections 
    
	    if (val > 1) { // HTML5 version doesnt like triangle with only 2 sides 
    
	        piesurface = surface_create(radius*2,radius*2)
            
	        draw_set_colour(colour);
	        draw_set_alpha(transparency);
        
	        surface_set_target(piesurface)
        
	        draw_clear_alpha(c_blue,0.7)
	        draw_clear_alpha(c_black,0)
        
	        draw_primitive_begin(pr_trianglefan);
	        draw_vertex(radius, radius);
        
	        for(i=0; i<=val; i++) {
	            len = (i*sizeofsection)+90; // the 90 here is the starting angle
	            tx = lengthdir_x(radius, len);
	            ty = lengthdir_y(radius, len);
	            draw_vertex(radius+tx, radius+ty);
	        }
        
	        draw_primitive_end();
        
	        draw_set_alpha(1);
        
	        gpu_set_blendmode(bm_subtract)
	        draw_set_colour(c_black)
	        draw_circle(radius-1, radius-1,radius-width,false)
	        gpu_set_blendmode(bm_normal)

	        surface_reset_target()
     
	        draw_surface(piesurface,x-radius, y-radius)
        
	        surface_free(piesurface)
        
	    }
    
	}
}

/// @desc Draws a surface normally (top-left origin), but rotates around the center origin
function draw_surface_rotated_ext(_surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
    var _halfW = surface_get_width(_surf) * 0.5 * _xscale;
    var _halfH = surface_get_height(_surf) * 0.5 * _yscale;
    
    var _rad = degtorad(_rot);
    
    var _rotX = -_halfW * cos(_rad) - _halfH * sin(_rad);
    var _rotY = -_halfW * -sin(_rad) - _halfH * cos(_rad);

    // If you want to *always* draw from center origin, remove `_half`s below
    var _surfX = _x + _halfW + _rotX;
    var _surfY = _y + _halfH + _rotY;

    draw_surface_ext(_surf, _surfX, _surfY, _xscale, _yscale, _rot, _col, _alpha);
}

/**
	@desc Draws a gradient effect using shader (not gpu intensive) (transparent -> given color)
	@param {real} x X position of the bottom left corner
	@param {real} y Y position of the bottom right corner
	@param {real} width The width of the gradient
	@param {real} height The default height of the gradient
	@param {real} angle The angle of the gradient
	@param {Constant.Color} color The color of the gradient
	@param {function} move The funciton to use to move the gradient (Default dsin)
	@param {real} intensity The intensity of the gradient (How many pixels will it move +/-)
	@param {real} rate The rate of the movement (Multiplies to the function declared in 'move')
*/
function draw_gradient_ext(x = 0, y = 480, width = 640, height = 40, angle = 0, color = c_white, move = dsin, intensity = 20, rate = 1) {
	static displace = 0;
	static time = 0;
	time++;
	displace = move(time * rate) * intensity;
	height += displace;
	gpu_set_blendmode(bm_add);
	draw_surface_ext(oGlobal.GradientSurf, x - height / 2 * dcos(angle - 90), y - height / 2 * -dsin(angle - 90), width / 640, height / 480, angle, color, 1);
	gpu_set_blendmode(bm_normal);
}

///@desc Sets the noise sprite to use for a noise fade
function SpriteNoiseSet(sprite = sprNoiseRect) constructor
{
	NoiseSprite = sprite;
	NoiseTexture = sprite_get_texture(sprite, 0);
	Noiseuvs = texture_get_uvs(NoiseTexture);
}

/**
	@desc Draws a sprite with a noise fade in (Will automatically convert to normal draw_sprite if the duration is reached)
	@param {Asset.sprite} sprite		The sprite to draw
	@param {real} subimg				The subimg of the sprite
	@param {real} x						The x position of the sprite to draw
	@param {real} y						The y position of the sprite to draw
	@param {real} time					The time of the noise fade (The value of this needs to change constantly)
	@param {real} duration				The total duration of the fade in
	@param {Asset.sprite} noise_sprite	The noise sprite to use (It has to be a sprite of a noise)
*/
function draw_noise_fade_sprite(sprite, subimg, x, y, time, duration, noise_sprite = sprNoiseRect)
{
	if !variable_instance_exists(id, "NoiseVars")
		NoiseVars = new SpriteNoiseSet(noise_sprite);
	if time < duration
	{
		var UV = shader_get_uniform(shdNoiseFade, "mainuv"),
			Rat = shader_get_uniform(shdNoiseFade, "mainrat"),
			Level = shader_get_uniform(shdNoiseFade, "mainlev"),
			Sampler = shader_get_sampler_index(shdNoiseFade, "mainnoise"),
			NoiseFadeLevel = 1 - time / duration,
			gettexture = sprite_get_texture(sprite, subimg),
			texuvs = texture_get_uvs(gettexture);
		shader_set(shdNoiseFade);
		texture_set_stage(Sampler, NoiseVars.NoiseTexture);
		shader_set_uniform_f(Level, NoiseFadeLevel);
		shader_set_uniform_f(UV, NoiseVars.Noiseuvs[0], NoiseVars.Noiseuvs[1], texuvs[0], texuvs[1]);
		shader_set_uniform_f(Rat, (NoiseVars.Noiseuvs[2] - NoiseVars.Noiseuvs[0]) / (texuvs[2] - texuvs[0]), (NoiseVars.Noiseuvs[3] - NoiseVars.Noiseuvs[1]) / (texuvs[3] - texuvs[1]));
		draw_set_alpha(1 - NoiseFadeLevel);
		draw_sprite(sprite, subimg, x, y);
		draw_set_alpha(1);
		shader_reset();
	}
	else draw_sprite(sprite, subimg, x, y);
}

/**
	@desc Draws a sprite with a noise fade in (Will automatically convert to normal draw_sprite_ext if the duration is reached)
	@param {Asset.sprite} sprite		The sprite to draw
	@param {real} subimg				The subimg of the sprite
	@param {real} x						The x position of the sprite to draw
	@param {real} y						The y position of the sprite to draw
	@param {real} xscale				The xscale of the sprite to draw
	@param {real} yscale				The yscale of the sprite to draw
	@param {real} rot					The rotation of the sprite to draw
	@param {Constant.Color} col			The color of the sprite to draw
	@param {real} time					The time of the noise fade (The value of this needs to change constantly)
	@param {real} duration				The total duration of the fade in
	@param {Asset.sprite} noise_sprite	The noise sprite to use (It has to be a sprite of a noise)
*/
function draw_noise_fade_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, col, time, duration, noise_sprite = sprNoiseRect)
{
	if !variable_instance_exists(id, "NoiseVars")
		NoiseVars = new SpriteNoiseSet(noise_sprite);
	if time < duration
	{
		var UV = shader_get_uniform(shdNoiseFade, "mainuv"),
			Rat = shader_get_uniform(shdNoiseFade, "mainrat"),
			Level = shader_get_uniform(shdNoiseFade, "mainlev"),
			Sampler = shader_get_sampler_index(shdNoiseFade, "mainnoise"),
			NoiseFadeLevel = 1 - time / duration,
			gettexture = sprite_get_texture(sprite, subimg),
			texuvs = texture_get_uvs(gettexture);
		shader_set(shdNoiseFade);
		texture_set_stage(Sampler, NoiseVars.NoiseTexture);
		shader_set_uniform_f(Level, NoiseFadeLevel);
		shader_set_uniform_f(UV, NoiseVars.Noiseuvs[0], NoiseVars.Noiseuvs[1], texuvs[0], texuvs[1]);
		shader_set_uniform_f(Rat, (NoiseVars.Noiseuvs[2] - NoiseVars.Noiseuvs[0]) / (texuvs[2] - texuvs[0]), (NoiseVars.Noiseuvs[3] - NoiseVars.Noiseuvs[1]) / (texuvs[3] - texuvs[1]));
		draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, col , 1 - NoiseFadeLevel);
		shader_reset();
	}
	else draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, col , 1);
}

/**
	@desc Draws an rectangle with the colors inverted inside of it
	@param {real} x1	The top left x position of the rectangle
	@param {real} y1	The top left y position of the rectangle
	@param {real} x2	The bottom right x position of the rectangle
	@param {real} y2	The bottom right y position of the rectangle
*/
function draw_invert_rect(x1, y1, x2, y2)
{
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero);
	draw_rectangle(x1, y1, x2, y2, false);
	gpu_set_blendmode(bm_normal);
}

/**
	@desc Draws an triangle with the colors inverted inside of it
	@param {real} x1	The x coordinate of the triangle's first corner
	@param {real} y1	The y coordinate of the triangle's first corner
	@param {real} x2	The x coordinate of the triangle's secpnd corner
	@param {real} y2	The y coordinate of the triangle's secpnd corner
	@param {real} x3	The x coordinate of the triangle's third corner
	@param {real} y3	The y coordinate of the triangle's third corner
*/
function draw_invert_triangle(x1, y1, x2, y2, x3, y3)
{
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero);
	draw_triangle(x1, y1, x2, y2, x3, y3, false);
	gpu_set_blendmode(bm_normal);
}

/**
	@desc Draws an circle with the colors inverted inside of it
	@param {real} x		 The top left x position of the circle
	@param {real} y		 The top left y position of the circle
	@param {real} radius The radius of the circle
*/
function draw_invert_cricle(x, y, radius)
{
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero);
	draw_circle(x, y, radius, false);
	gpu_set_blendmode(bm_normal);
}

/**
	@desc Draws an polygon with the colors inverted inside of it, make sure the points are in a clockwise/anticlockwise order or else there will be visual bugs (no auto sort for now)
	@param {Array<Array<Real>>} Vertexes	The vertexes of the polygon in the form of [[x1, y1], [x2, y2]...]
*/
function draw_invert_polygon(vertexes)
{
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero);
	var i = 1, n = array_length(vertexes) - 1;
	repeat n - 1
	{
		draw_triangle(vertexes[0][0], vertexes[0][1], vertexes[i][0], vertexes[i][1],
					vertexes[i + 1][0], vertexes[i + 1][1], false);
		++i;
	}
	gpu_set_blendmode(bm_normal);
}