/// @description Camera Functions
var camera = view_camera[0]

var xx = global.camera_x
var yy = global.camera_y

// Zoom functionality
var view_w = global.zoom_level * global.zoom_width
var view_h = global.zoom_level * global.zoom_height

// Screen shaking
if global.shake > 0
{
	xx += random_range(-global.shake, global.shake)
	yy += random_range(-global.shake, global.shake)
	
	global.shake = max(0, global.shake - ((1 / global.shake_length) * global.shake_magnitude))
}

camera_set_view_pos(camera, xx - (view_w * 0.5), yy - (view_h * 0.5))
camera_set_view_size(camera, view_w, view_h)

