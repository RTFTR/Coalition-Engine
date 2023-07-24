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
	var shader_blur = instance_create_depth(0,0,-1000,blur_shader)
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
function Effect_Shader(shd, uniforms)
{
	var eff = instance_create_depth(0, 0, -100000, shaderEffect)
	with(eff)
	{
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
function Camera_Shake(amount)
{
	oGlobal.camera_shake_i = ceil(amount);
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

	_point_h *= pi
	_point_v *= pi

	var sinX = sin(_point_h);
	var cosX = cos(_point_h);
 
	var sinY = sin(_point_v);
	var cosY = cos(_point_v);
	
	var number_of_nodes = array_length(nodes)
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i]

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node
	};

	draw_set_colour(_colour)

	var number_of_edges = array_length(edges)
	for (var i = 0; i < number_of_edges; ++i) {
	
		var edge = edges[i]
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size))


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

	_point_h *= pi
	_point_v *= pi

	var sinX = sin(_point_h);
	var cosX = cos(_point_h);
 
	var sinY = sin(_point_v);
	var cosY = cos(_point_v);
	
	var number_of_nodes = array_length(nodes)
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i]

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node
	};

	draw_set_colour(_colour)

	var number_of_edges = array_length(edges)
	for (var i = 0; i < number_of_edges; ++i) {
	
		var edge = edges[i]
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line_width(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size),_width)
		
		if _edge_circ
		draw_circle(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_width/2,false)
	};
	
}

function draw_circle_width(x, y, radius = 100, thickness = 4, segments = 20, color = c_white)
{
	var jadd = 360/segments;
	draw_set_color(color);
	draw_primitive_begin(pr_trianglestrip);
	for (var j = 0; j <= 360; j+=jadd)
	{
	    draw_vertex(x + lengthdir_x(radius, j), y + lengthdir_y(radius, j));
		radius += thickness;
	    draw_vertex(x + lengthdir_x(radius, j), y + lengthdir_y(radius, j));
		radius -= thickness;
	}
	draw_primitive_end();
}

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

//function draw_gradient(x = 0, y = 480, width = 640, height = 40, angle = 0, color = c_white, bound_dist = -1, move = sin, intensity = 20, rate = 1) {
function draw_gradient(x = 0, y = 480, width = 640, height = 40, angle = 0, color = c_white, move = dsin, intensity = 20, rate = 1) {
	//Unused version with more functions (WIP)
	static displace = 0;
	static time = 0;
	time++;
	displace = move(time * rate) * intensity;
	height += displace;
	//var WidthX = width * dcos(angle);
	//var WidthY = width * -dsin(angle);
	//var HeightX = height * dcos(angle + 90);
	//var HeightY = height * -dsin(height + 90);
	////Bottom left, Bottom right, Top left
	//draw_triangle_color(x, y, x + WidthX, y + WidthY, x + HeightX, y - HeightY, color, color, c_black, false);
	////Top left, Top right, Bottom right
	//draw_triangle_color(x + HeightX, y - HeightY, x + WidthX + HeightX, y + WidthY - HeightY, x + WidthX, y + WidthY, c_black, c_black, color, false);


	gpu_set_blendmode(bm_add);
	draw_surface_ext(oGlobal.GradientSurf, x - height / 2 * dcos(angle - 90), y - height / 2 * -dsin(angle - 90), width / 640, height / 480, angle, color, 1);
	gpu_set_blendmode(bm_normal);
}