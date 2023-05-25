if state = 0
{
	var _x = x,
		_y = y,
		_angle = image_angle,
		
		_target_x = target_x,
		_target_y = target_y,
		_target_angle = target_angle,
		
		_timer = timer_move;
	
	if charge_sound
	{
		audio_play(snd_gb_charge, true, false, 1, 1.2);
		charge_sound = false;
	}
	
	if _timer <= time_move
	{
		_x += (_target_x - _x) * (5 / time_move);
		_y += (_target_y - _y) * (5 / time_move);
		_angle += (_target_angle - _angle) * (5 / time_move);
		
		_x += sign(_target_x - _x) / 2;
		_y += sign(_target_y - _y) / 2;
		_angle += sign(_target_angle - _angle) / 2;
		
		if abs(_x - _target_x) < 1.5  _x = _target_x;
		if abs(_y - _target_y) < 1.5  _y = _target_y;
		if abs(_angle - _target_angle) < 1.5  _angle = _target_angle;
		
		_timer++
	}
	if _timer = time_move or !time_move
	{
		state = 1;
		_timer = 0;
		_x = _target_x;
		_y = _target_y;
		_angle = _target_angle;
		alarm[0] = max(1, time_pause);
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
	image_index += 0.5;
if state == 4
{		
	var _angle = image_angle,
		
		_yscale = image_yscale;
	
	if image_index = image_number - 1 image_index--;
	
	image_index += 0.5;
	direction = _angle - 180;
	
	var _blast_timer = timer_blast,
		_exit_timer = timer_exit,
		_size = beam_scale;
	
	if _blast_timer = 0
	{
		if _yscale > 1
		{
			Camera_Shake(5 * _yscale);
			if blurring	Blur_Screen(time_blast, _yscale);
		}
		if global.RGBBlaster
			oGlobal.RGBShake = 5 * _yscale;
		if release_sound
		{
			audio_play(snd_gb_release, true, 0, 1, 1.2);
			audio_play(snd_gb_release2, true, 0, 0.8, 1.2);
	
			release_sound = false;
		}
	}
	var _x = x,
		_y = y,
		_alpha = beam_alpha,
		
		_xscale = image_xscale,
		_end_point = e,
	
		_blast_timer = timer_blast,
		_exit_timer = timer_exit,
		_size = beam_scale;
	
	_blast_timer++;
	_exit_timer++;
	_end_point += speed;
	if _exit_timer >= time_stay and _exit_timer < time_stay + 10 speed += 0.5;
	else if (_exit_timer >= time_stay + 10 and !check_outside()) speed *= 1.1;
	
	if _blast_timer < 10 _size += ((30 * _yscale) / 8);
	
	if _blast_timer >= 10 + time_blast
	{
		_size *= sqrt(0.8);
		_alpha -= 0.05;
		
		if _size <= 2 destroy = 1;
	}
	
	var beam_siner = sin(_blast_timer / pi) * _size / 4;
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