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
e = 0;

function check_outside()
{
	var cam = view_camera[0];
	var view_x = camera_get_view_x(cam);
	var view_y = camera_get_view_y(cam);
	var view_w = camera_get_view_width(cam);
	var view_h = camera_get_view_height(cam);
	
	return !rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, view_x, view_y, view_x + view_w, view_y + view_h) 
	and (
		(x < -sprite_width) or 
		(x > (room_width + sprite_width)) or
		(y > (room_height + sprite_height)) or
		(y < (-sprite_height))
		)
}

function auto_destroy()
{
	if check_outside()
	{
		if timer_exit >= time_stay and destroy != 0
			instance_destroy();
	}	

}

