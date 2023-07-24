depth = -10000;

restart_timer = 0;
restart_ender = irandom_range(30, 120);
restart_tip = tips();

camera_scale_x = 1;
camera_scale_y = 1;
camera_view_width = 640;
camera_view_height = 480;
camera_shake_i = 0;

camera_x = 0;
camera_y = 0;
camera_angle = 0;
camera_target = noone;
camera_previous_target = noone;
Main_Camera = view_camera[0];

quit_timer = 0;

fader_color = c_black;
fader_alpha = 0;

effect_shader =
[
	
];
effect_surf = [-1];
effect_param =
[
	["", 1],
];

RGBShake = 0;

Song = 
{
	Activate : false,
	Name : "",
	Dist : -20,
	Time : 0,
};

Fade =
{
	Method : FADE.DEFAULT,
	Activate : [
		[false, 0, 0],
		[false, 0, 0],
		[false, 0, 0, 32],
	],
	Timer : 0
};
FadeTime = 0;

Naming =
{
	Enabled : true,
	Allowed : true,
	Named : false,
	State : 1
};

shader_enable_corner_id(true);
GradientSurf = -1;