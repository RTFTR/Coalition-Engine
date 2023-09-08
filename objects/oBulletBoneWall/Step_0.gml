if warn_color_swap
{
	WarnTimer++;
	if !(WarnTimer % 5) and time_warn
	{
		var change = (WarnTimer % 10) == 5
		warn_color = change ? c_yellow : c_red;
		warn_alpha_filled = change ? 0.25 : 0.5;
	}
}

if state == 2
{
	var dir_ang_x = -dsin(dir), dir_ang_y = dcos(dir);
	if !timer and sound_create
	{
		audio_play(snd_bonewall);
	}
	else
	{
		if timer < time_move
		{
			var spd = floor((height) / time_move);
			
			x -= spd * dir_ang_y;
			y -= spd * dir_ang_x;
		}
		if (timer >= time_move and timer <= time_move + time_stay)
		{
			x = target_x - height * dir_ang_y;
			y = target_y - height * dir_ang_x;
		}
		if timer > time_move + time_stay
		{
			var spd = floor(height / time_move),
				kill_check = false;
			
			x += spd * dir_ang_y;
			y += spd * dir_ang_x;
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