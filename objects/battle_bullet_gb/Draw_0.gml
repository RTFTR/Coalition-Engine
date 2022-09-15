var color = c_white;
var _type = type;
if type = 1 color = c_aqua;
if type = 2 color = c_orange;
if type = 3 color = c_red;

Battle_Masking_Start(true);

if state = 0
{
	var _x = x;
	var _y = y;
	var _angle = image_angle;
	
	var _target_x = target_x;
	var _target_y = target_y;
	var _target_angle = target_angle;
	
	var _timer = timer_move;
	
	if charge_sound == 1
	{
		audio_stop_sound(snd_gb_charge);
		var beam_sfx = audio_play_sound(snd_gb_charge,50,0);
		audio_sound_pitch(beam_sfx,1.2);
	
		charge_sound = 0;
	}
	
	if _timer <= time_move
	{
		_x += (_target_x - _x) * (5 / time_move)
		_y += (_target_y - _y) * (5 / time_move)
		_angle += (_target_angle - _angle) * (5 / time_move)
		
		if _x < _target_x _x += 0.5;
		if _x > _target_x _x -= 0.5;
		if _y < _target_y _y += 0.5;
		if _y > _target_y _y -= 0.5;
		if _angle < _target_angle _angle += 0.5;
		if _angle > _target_angle _angle -= 0.5;
		if abs(_x - _target_x) < 1.5 _x = _target_x;
		if abs(_y - _target_y) < 1.5 _y = _target_y;
		if abs(_angle - _target_angle) < 1.5 _angle = _target_angle;
		
		_timer++
	}
	if _timer = time_move or time_move = 0
	{
		state = 1;
		_timer = 0;
		_x = _target_x;
		_y = _target_y;
		_angle = _target_angle;
		alarm[0] = (time_pause <= 0 ? 1 : time_pause);
	}
	x = _x;
	y = _y;
	image_angle = _angle;
	
	target_x = _target_x;
	target_y = _target_y;
	target_angle = _target_angle;
	
	timer_move = _timer;
}

if state = 2 
{
	state = 3;
	alarm[0] = 8;
	alarm[1] = 9;
}

if state = 3 
	image_index += 0.5

if state = 4
{
	var _x = x;
	var _y = y;
	
	var _angle = image_angle;
	var _alpha = beam_alpha;
	
	var _xscale = image_xscale;
	var _yscale = image_yscale;
	var _end_point = e;
	
	if image_index = 5 image_index = 4; image_index += 0.5
	direction = _angle - 180;
	
	var _blast_timer = timer_blast;
	var _exit_timer = timer_exit;
	var _size = beam_scale;
	
	if _blast_timer = 0
	{
		if _yscale >= 2
		{
			global.shake = 5;
			if blurring = true
				Blur_Screen(time_blast, _yscale);
		}
		if release_sound == 1
		{
			audio_stop_sound(snd_gb_release);
			var beam_up_sfx = audio_play_sound(snd_gb_release,50,0);
			audio_sound_pitch(beam_up_sfx,1.2);
	
			audio_stop_sound(snd_gb_release2);
			var beam_sfx_a = audio_play_sound(snd_gb_release2,50,0);
			audio_sound_pitch(beam_sfx_a,1.2);
			audio_sound_gain(beam_sfx_a,0.8,0);
	
			release_sound = 0;
		}
	}
	_blast_timer++;
	_exit_timer++;
	_end_point += speed;
	if _exit_timer >= time_stay and _exit_timer < time_stay + 10 speed += 0.5
	else if _exit_timer >= time_stay + 10 speed *= 1.1
	
	if _blast_timer < 10
		_size += ((30 * _yscale) / 8);
	
	if _blast_timer >= 10 + time_blast
	{
		_size *= sqrt(0.8);
		_alpha -= 0.05;
		
		if _size <= 2 destroy = 1;
	}
	
	var beam_siner = (((sin(_blast_timer / pi)) * _size) / 4);
	
	var rx = 0//(random(2) - random(2))
    var ry = 0//(random(2) - random(2))
	
	draw_set_alpha(_alpha);
	draw_set_color(color);
	var xs = lengthdir_x(35 * _xscale, image_angle);
	var ys = lengthdir_y(35 * _xscale, image_angle);
	var xe = lengthdir_x(1200 + _end_point, image_angle);
	var ye = lengthdir_y(1200 + _end_point, image_angle);
	
	draw_line_width(x + xs + rx, y + ys + ry, x + xe + rx, y + ye + ry, _size + beam_siner);
	
	var xa = lengthdir_x(25 * _xscale, image_angle);
	var ya = lengthdir_y(25 * _xscale, image_angle);
	var xb = lengthdir_x(30 * _xscale, image_angle);
	var yb = lengthdir_y(30 * _xscale, image_angle);
	
	draw_line_width(x + xs + rx, y + ys + ry, x + xa + rx, y + ya + ry, (_size / 2) + beam_siner);
	draw_line_width(x + xs + rx, y + ys + ry, x + xb + rx, y + yb + ry, (_size / 1.25) + beam_siner);
	
	var collisiondir_x = lengthdir_x(1, image_angle - 90)
	var collisiondir_y = lengthdir_y(1, image_angle - 90)
	if global.inv <= 0
	{
		for (var c = 0; c < 5; c++)
		{
			var x_f = ((collisiondir_x * (beam_scale + beam_siner)) / 2) * (c / 8);
			var y_f = ((collisiondir_y * (beam_scale + beam_siner)) / 2) * (c / 8);
			
			
			draw_set_color(c_red)
			//draw_line_width((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) + y_f, 10)
			//draw_line_width((x + xs + rx) + x_f, (y + ys + ry) + y_f, (x + xe + rx) + x_f, (y + ye + ry) - y_f, 10)
			draw_rectangle((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) + y_f,0)
			draw_set_color(color)

			//if collision_line((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) + y_f, obj_battle_soul, false, false)
			//or collision_line((x + xs + rx) + x_f, (y + ys + ry) + y_f, (x + xe + rx) + x_f, (y + ye + ry) - y_f, obj_battle_soul, false, false)
			var sx = obj_battle_soul.x;
			var sy = obj_battle_soul.y;
			if rectangle_in_rectangle((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) + y_f,sx-4,sy-4,sx+4,sy+4)
			{
				Soul_Hurt()
				if beam_alpha >= 0.8// and beam_scale > 2
				{
					var collision = true;
					if _type != 0 and _type != 3
					{
						collision = (floor(obj_battle_soul.x) != floor(obj_battle_soul.xprevious) 
									or floor(obj_battle_soul.y) != floor(obj_battle_soul.yprevious));
						collision = (_type == 1 ? collision : !collision);
					}
					if collision
						Soul_Hurt();
				}
				
				//draw_set_color(c_green)
				//draw_line((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) - y_f)
				//draw_line((x + xs + rx) + x_f, (y + ys + ry) + y_f, (x + xe + rx) + x_f, (y + ye + ry) + y_f)
			}
		}
	}
	
	auto_destroy();
	
	x = _x;
	y = _y;
	image_angle = _angle;
	beam_alpha = _alpha;
	
	image_xscale = _xscale;
	image_yscale = _yscale;
	
	timer_blast = _blast_timer;
	timer_exit = _exit_timer;
	beam_scale = _size;
	e = _end_point;	
}

draw_set_alpha(1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha);
draw_set_color(c_white);
Battle_Masking_End()

