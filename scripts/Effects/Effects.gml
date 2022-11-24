///@desc Fades the screen
///@param {real}  start				The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
///@param {real}  duration			The time the fader fades from start to end
///@param {real}  delay				The delay for the fader to fade (Default 0)
///@param {Constant.Color} color	The color of the fader (Default c_black)
function Fader_Fade(start, target, duration, delay = 0, color = c_black)
{
	oGlobal.fader_color = color;
	TweenFire(oGlobal,EaseLinear, TWEEN_MODE_ONCE, false, delay, duration, "fader_alpha", start, target);
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
	TweenFire(oGlobal, ease, TWEEN_MODE_ONCE, false, 0, duration, "camera_angle", ooGlobal.camera_angle, target);
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

///@desc Shakes the Camera
///@param Amount	The amount in pixels to shake
function Camera_Shake(amount)
{
	oGlobal.camera_shake_i = ceil(amount);
	//oGlobal.camera_shake_t++;
}

///@desc Sets the scale of the Camera
///@param Scale_X		The X scale of the camera
///@param Scale_Y		The Y scale of the camera
function Camera_Scale(sx, sy)
{
	oGlobal.camera_scale_x = sx;
	oGlobal.camera_scale_y = sy;
}

///@desc Sets the X and Y position of the Camera
///@param x The x position
///@param y The y position
function Camera_SetPos(xx, yy)
{
	oGlobal.camera_x = xx;
	oGlobal.camera_y = yy;
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
function draw_cube_width(_draw_x,_draw_y,_size,_point_h,_point_v,_colour,_width, _edge_circ = true) {
	
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

function draw_circle_width(x,y,radius=100, thickness=4,segments=20)
{
	var jadd = 360/segments;
	draw_set_color(c_black);
	draw_primitive_begin(pr_trianglestrip);
	for (var j = 0; j <= 360; j+=jadd)
	{
	    draw_vertex(x+lengthdir_x(radius,j),y+lengthdir_y(radius,j));
	    draw_vertex(x+lengthdir_x(radius+thickness,j),y+lengthdir_y(radius+thickness,j));
	}
	draw_primitive_end();
}
