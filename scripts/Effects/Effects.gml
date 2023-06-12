///@desc Fades the screen
///@param {real}  start				The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  duration			The time the fader fades from start to end
///@param {real}  delay				The delay for the fader to fade (Default 0)
///@param {Constant.Color} color	The color of the fader (Default c_black)
function fader_fade(start, target, duration, delay = 0, color = c_black) {
	obj_Global.fader_color = color;
	TweenFire(obj_Global, EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
}

function fade_out(mode = FADE.CIRCLE, duration = 30, delay = 60) {
	with obj_Global
	{
		Fade.Activate[mode, 0] = true;
		Fade.Activate[mode, 1] = duration;
		Fade.Activate[mode, 2] = delay;
	}
}

///@desc Blurs the screen
///@param {real} duration	The duration to blur
///@param {real} amount		The amount to blur
function blur_screen(duration, amount) {
	var shader_blur = instance_create_depth(0,0,-1000,obj_BlurShader)
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
function blur_motion(length, direction) {
    if (length > 0) 
	{
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
    }
	else
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 
			image_yscale, image_angle, image_blend, image_alpha);
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
function blur_motion_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha, length, direction) {
    if (length > 0) 
	{
		var step, dir, px, py, a;
        step = 3;
        px = dcos(direction);
        py = -dsin(direction);
 
        a = image_alpha / (length / step);
        if (a >= 1) 
		{
            draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha);
            a /= 2;
        }
 
        for(var i = length; i >= 0; i -= step) 
            draw_sprite_ext(sprite, subimg, xx + (px * i), yy + (py * i), xscale, yscale, angle, blend, a);
    }
	else 
        draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, angle, blend, alpha);
}

///@desc Rotates the camera
///@param {real} start		The start angle of the camera
///@param {real} target		The target angle of the camera
///@param {real} duration	The time taken for the camera to rotate
///@param {function} Easing	The ease of the rotation
///@param {real} delay 		The delay of the animation
function camera_rotate(start, target, duration, ease = EaseLinear, delay = 0) {
	TweenFire(obj_Global, ease, TWEEN_MODE_ONCE, false, delay, duration, "camera_angle", start, target);
}

///@desc Creates the effect with the shader given
///@param {Assets.GMShader} Shader	The shader to use
///@param {string} Parameter_Name	The name of the uniform parameter
///@param {real} Parameter_Value	The value of the uniform parameter
function effect_set_shader(shd) {
	var	param = ["", 1];
	for(var i = 1; i < argument_count; i+=2)
	{
		param[i - 1] = argument[i];
		param[i] = argument[i + 1];
	}
	var eff = instance_create_depth(0,0,-100000, obj_ShaderEffect)
	with(eff)
	{
		effect_shader = shd;
		effect_param = param;
	}
	return eff
}

///@desc Sets the uniform vars of the given shader, if drawn using effect_set_shader() (1 VECTOR ONLY)
///@param {Assets.GMShader} Shader	The name of the shader to apply to
///@param {string} Param_Name	The name of the uniform variable
///@param {string} Param_value	The value of the uniform variable
function effect_set_param() {
	with obj_ShaderEffect
	{
		if effect_shader == argument[0]
		{
			for(var i = 1; i < argument_count; i += 2)
			{
				effect_param = [argument[i], argument[i + 1]];
			}
		}
	}
}

///@desc Shakes the Camera
///@param {real} Amount		The amount in pixels to shake
function camera_shake(amount) {
	obj_Global.camera_shake_i = ceil(amount);
}

///@desc Sets the scale of the Camera
///@param {real} Scale_X		The X scale of the camera
///@param {real} Scale_Y		The Y scale of the camera
///@param {real} duration		The anim duration of the scaling
///@param {function} ease		The easing of the animation
function camera_scale(sx, sy, duration = 0, ease = EaseLinear) {
	with obj_Global
	{
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_scale_x", camera_scale_x, sx);
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_scale_y", camera_scale_y, sy);
	}
}

///@desc Sets the X and Y position of the Camera
///@param {real}				x The x position
///@param {real}				y The y position
///@param {real} duration		The anim duration of the movement
///@param {function} ease		The easing of the animation
function camera_set_pos(x, y, duration = 0, ease = EaseLinear) {
	with obj_Global
	{
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_x", camera_scale_x, x);
		TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_y", camera_scale_y, y);
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
	for (var i = 0; i < number_of_nodes; ++i)
	{
	
		var node = nodes[i]

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node;
	}

	draw_set_colour(_colour);

	var number_of_edges = array_length(edges)
	for (var i = 0; i < number_of_edges; ++i)
	{
	
		var edge = edges[i];
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line_width(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size),_width);
		
		if _edge_circ
			draw_circle(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_width/2,false);
	};
	
}

function draw_circle_width(x, y, radius = 100, thickness = 4, segments = 20)
{
	var jadd = 360/segments;
	draw_set_color(c_black);
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
function instance_create_trail(duration = 30) {
	part_system_depth(global.TrailS, depth + 1);
	part_type_sprite(global.TrailP, sprite_index, 0, 0, 0);
	part_type_life(global.TrailP, duration, duration);
	part_type_orientation(global.TrailP, image_angle, image_angle, 0, 0, 0);
	part_particles_create_color(global.TrailS, x, y, global.TrailP, image_blend, 1);
}

function draw_circular_bar(x ,y ,value, max, colour, radius, transparency, width) {
	if (value > 0) // No point even running if there is nothing to display (also stops /0)
	{
	    var i, len, tx, ty, val;
    
	    var numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
	    var sizeofsection = 360/numberofsections
    
	    val = (value/max) * numberofsections 
    
	    if (val > 1) // HTML5 version doesnt like triangle with only 2 sides 
		{
	        piesurface = surface_create(radius*2,radius*2)
            
	        draw_set_colour(colour);
	        draw_set_alpha(transparency);
        
	        surface_set_target(piesurface)
        
	        draw_clear_alpha(c_blue,0.7)
	        draw_clear_alpha(c_black,0)
        
	        draw_primitive_begin(pr_trianglefan);
	        draw_vertex(radius, radius);
        
	        for(i=0; i<=val; i++)
			{
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
