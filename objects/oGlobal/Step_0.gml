// Camera movement
var cam = view_camera[0],
	
	cam_scale_x = MainCamera.Scale[0],
	cam_scale_y = MainCamera.Scale[1],
		
	cam_width  = MainCamera.view_width / cam_scale_x,
	cam_height = MainCamera.view_height / cam_scale_y,
		
	cam_angle  = MainCamera.angle,
		
	cam_target = MainCamera.target,
		
	cam_shake_x = 0,
	cam_shake_y = 0;
	
// Targetting
var camToX = MainCamera.x,
	camToY = MainCamera.y;
if cam_target != MainCamera.previous_target
	camera_set_view_target(cam, cam_target);
if (cam_target != noone and instance_exists(cam_target)) {
	camToX = cam_target.x - cam_width / 2;
	camToY = cam_target.y - cam_height / 2;
}
	
// Shaking
var shake = 0;
if MainCamera.shake_i > 0
{
	shake = MainCamera.shake_i
	if shake > 0 MainCamera.shake_i -= MainCamera.decrease_i;
	cam_shake_x = random_range(-shake, shake);
	cam_shake_y = random_range(-shake, shake);
	camera_set_view_target(cam, noone);
	if MainCamera.shake_i == 0
		camera_set_view_target(cam, MainCamera.previous_target);
}
camera_set_view_pos(cam, camToX + cam_shake_x, camToY + cam_shake_y);
	
// You know
camera_set_view_size(cam, cam_width, cam_height);
camera_set_view_angle(cam, cam_angle);
MainCamera.previous_target = cam_target;
