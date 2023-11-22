/**
	Fades the screen
	@param {real}  start			The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
	@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
	@param {real}  duration			The time the fader fades from start to end
	@param {real}  delay			The delay for the fader to fade (Default 0)
	@param {color} color	The color of the fader (Default current color)
*/
function Fader_Fade(start = oGlobal.fader_alpha, target, duration, delay = 0, color = oGlobal.fader_color)
{
	oGlobal.fader_color = color;
	TweenFire(oGlobal, "", 0, false, delay, duration, "fader_alpha", start, target);
}
/**
	Fades the screen and fades back out to destined alpha
	@param {real}  start			The beginning alpha of the fader (0 = screen visible, 1 = screen not visible)
	@param {real}  target			The ending alpha of the fader (0 = screen visible, 1 = screen not visible)
	@param {real}  final			The final alpha of the fader (0 = screen visible, 1 = screen not visible)
	@param {real}  in_duration		The time the fader fades from start to end
	@param {real}  duration			The time the fader holds the target alpha
	@param {real}  out_duration		The time the fader fades from end to final
	@param {real}  delay			The delay for the fader to fade (Default 0)
	@param {color} color	The color of the fader (Default current color)
*/
function Fader_Fade_InOut(start = oGlobal.fader_alpha, target, final, in_dur, duration, out_dur, delay = 0, color = oGlobal.fader_color)
{
	with oGlobal
	{
		fader_color = color;
		TweenFire(self, "", 0, false, delay, in_dur, "fader_alpha", start, target);
		TweenFire(self, "", 0, false, delay + in_dur + duration, out_dur, "fader_alpha>", final);
	}
}

function Fade_Out(mode = FADE.CIRCLE, duration = 30, delay = 60)
{
	with oGlobal.Fade
	{
		Activate[mode, 0] = true;
		Activate[mode, 1] = duration;
		Activate[mode, 2] = delay;
	}
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

/**
	@desc Creates a motion blur of a sprite
	@param {real} sprite			The sprite to blur
	@param {real} subimg			The image index of the sprite
	@param {real} x					The x position
	@param {real} y					The y position
	@param {real} xscale			The xscale of the sprite
	@param {real} yscale			The yscale of the sprite
	@param {real} angle				The angle fo the sprite
	@param {color} blend	The image blend of the sprite
	@param {real} alpha				The alpha of the sprite
	@param {real} length			The	length of the blur
	@param {real} direction			The direction of the blur
*/
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

///Creates a trail of the object using particles (Best not to use)
///@param {real} duration		The duration of the effect
function TrailStep(duration = 30) {
	part_system_depth(global.TrailS, depth + 1);
	part_type_sprite(global.TrailP, sprite_index, 0, 0, 0);
	part_type_life(global.TrailP, duration, duration);
	part_type_orientation(global.TrailP, image_angle, image_angle, 0, 0, 0);
	part_particles_create_color(global.TrailS, x, y, global.TrailP, image_blend, 1);
}

/**
	Creates a trail of given sprite and params
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

/**
	Splices the screen, similar to Edgetale run 3 final attack
	@param {real} x				The x position of the center of the split
	@param {real} y				The y position of the center of the split
	@param {real} direction		The direction of the split
	@param {real} in_duration	The duration of the split animation from 0 to full
	@param {real} duration		The delay before animating it back to 0
	@param {real} end_duration	The duration of the split animation from full to 0
	@param {real} distance		The distance of the split
	@param Easing			The easing method of the splice (TweenGMX Format)
*/
function SpliceScreen(x, y, dir, idur, dur, edur, dis, ease = "oQuad") {
	var _xs = x + 1000 * dcos(dir),
		_ys = y - 1000 * dsin(dir),
		_xe = x - 1000 * dcos(dir),
		_ye = y + 1000 * dsin(dir);
	with instance_create_depth(x, y, 0, oCutScreen, 
	{
		TEMPID : __cut_screen(_xs, _ys, _xe, _ye, 0)
	})
	{
		induration = idur;
		duration = dur;
		endduration = edur;
		id.dir = dir;
		displace = dis;
		func = ease;
	}
}