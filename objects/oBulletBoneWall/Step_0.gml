WarnTimer++;
if !(WarnTimer % 5) and time_warn
{
	warn_color = warn_color == c_red ? c_yellow : c_red;
	warn_alpha_filled = warn_alpha_filled == 0.5 ? 0.25 : 0.5;
}

if state == 2
{
	var dir_ang = [-dsin(dir), dcos(dir)];
	if !timer and sound_create
	{
		audio_stop_sound(snd_bonewall);
		audio_play_sound(snd_bonewall, 50, false);
	}
	else
	{
		if timer < time_move
		{
			var spd = floor((height) / time_move);
			
			x -= spd * dir_ang[1];
			y -= spd * dir_ang[0];
		}
		if (timer >= time_move and timer <= time_move + time_stay)
		{
			x = target_x - height * dir_ang[1];
			y = target_y - height * dir_ang[0];
		}
		if timer > time_move + time_stay
		{
			var spd = floor(height / time_move),
				kill_check = false;
			
			x += spd * dir_ang[1];
			y += spd * dir_ang[0];
			switch dir
			{
				case DIR.UP:
					kill_check = y < target_y;
				break
				case DIR.DOWN:
					kill_check = y > target_y;
				break
				case DIR.LEFT:
					kill_check = x < target_x;
				break
				case DIR.RIGHT:
					kill_check = x > target_x;
				break
			}
			if kill_check instance_destroy();
		}
	}
	timer++;
}