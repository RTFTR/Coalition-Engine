///@desc Camera movement
{
	var cam = view_camera[0],
	
		cam_scale_x = camera_scale_x,
		cam_scale_y = camera_scale_y,
		
		cam_width  = camera_view_width/cam_scale_x,
		cam_height = camera_view_height/cam_scale_y,
		
		cam_angle  = camera_angle,
		
		cam_target = camera_target,
		
		cam_shake_x = 0,
		cam_shake_y = 0;
	
	// Targetting
	var camToX = camera_x,
		camToY = camera_y;
	camera_set_view_target(cam, cam_target);
	if (cam_target != noone and instance_exists(cam_target)) {
		camToX = cam_target.x-cam_width /2;
		camToY = cam_target.y-cam_height/2;
	}
	
	// Shaking
	var shake = round(camera_shake_i);
	if shake camera_shake_i--;
	camera_shake_i = max(0, camera_shake_i);
	cam_shake_x = random_range(-shake, shake);
	cam_shake_y = random_range(-shake, shake);
	camera_set_view_pos(cam, camToX + cam_shake_x, camToY + cam_shake_y);
	
	// You know
	camera_set_view_size (cam,	cam_width, cam_height);
	camera_set_view_angle(cam,	cam_angle			 );
}