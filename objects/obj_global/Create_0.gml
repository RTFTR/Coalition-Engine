depth = -10000;
global.timer = 0;

global.camera_scale_x = 1;
global.camera_scale_y = 1;
global.camera_view_width = 640;
global.camera_view_height = 480;
global.camera_shake_i = 0;
global.camera_shake_t = 0;

global.camera_x = 0;
global.camera_y = 0;
camera_angle = 0;
global.camera_target = noone;
view_camera[0] = camera_create_view(x,y,640,480,0,noone,-1,-1,320,240);
global.Main_Camera = view_camera[0];

global.shake = 0;
global.shake_length = 1;
global.shake_random = 0;
global.shake_magnitude = 1.5;

global.soul_x = 0;
global.soul_y = 0;

global.show_hitbox = 0;

quit_timer = 0;

fader_color = c_black;
fader_alpha = 0;

effect_shader =
[
	shd_intensity
];
effect_surf = [-1, -1];
effect_param =
[
	["intensity", 1],
	["", 1],
];


