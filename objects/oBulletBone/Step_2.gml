var cam = view_camera[0],
	view_x = camera_get_view_x(cam),
	view_y = camera_get_view_y(cam),
	view_w = camera_get_view_width(cam),
	view_h = camera_get_view_height(cam),
	destroy = false;

if hspeed < 0 and bbox_left + 16 < view_x
or hspeed > 0 and bbox_right - 16 > view_x + view_w
or vspeed < 0 and bbox_bottom - 16 < view_y
or vspeed > 0 and bbox_top + 16 > view_y + view_h 
	destroy = true;

if destroy and destroyable
	instance_destroy();
