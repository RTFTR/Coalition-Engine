/// @description Camera Functions

var camera = global.Main_Camera

var xx = global.camera_x
var yy = global.camera_y
var shake_x = 0;
var shake_y = 0;
var target = global.cam_target

// Zoom functionality
var zoom = global.zoom_level
var view_w = global.cam_width / zoom
var view_h = global.cam_height / zoom

// Screen shaking
if global.shake > 0
{
	shake_x = random_range(-global.shake, global.shake)
	shake_y = random_range(-global.shake, global.shake)
	
	global.shake = max(0, global.shake - ((1 / global.shake_length) * global.shake_magnitude))
}
if instance_exists(target)
{
	camera_set_view_target(camera, target)
	camera_set_view_border(camera, 320, 240)
	global.camera_x = camera_get_view_x(camera);
	global.camera_y = camera_get_view_y(camera);
}
else
{
	camera_set_view_target(camera, noone)
	camera_set_view_pos(camera, xx + shake_x, yy + shake_y)
}
camera_set_view_size(camera, view_w, view_h)
camera_set_view_angle(camera, global.camera_angle)

