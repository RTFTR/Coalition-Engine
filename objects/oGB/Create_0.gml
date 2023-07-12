event_inherited();
kr = 10;

image_xscale = 1;
image_yscale = 1;
image_speed = 0;

target_y = 0;
target_x = 0;
target_angle = 0;

state = 0;
timer_move = 0;
timer_blast = 0;
timer_exit = 0;

time_move = 30;
time_pause = 16;
time_blast = 10;
time_stay = 0

charge_sound = 1;
release_sound = 1;
destroy = 0;

beam_scale = 0;
beam_alpha = 1;
beam_color = [c_fuchsia, c_white];
e = 0;

function auto_destroy()
{
	if check_outside()
	{
		if timer_exit >= time_stay and destroy != 0
			instance_destroy();
	}	

}

