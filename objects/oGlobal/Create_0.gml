depth = -10000;

restart_timer = 0;
restart_ender = irandom_range(30, 120);
restart_tip = tips();

Main_Camera = view_camera[0];
camera_x = 0;
camera_y = 0;
camera_scale_x = 1;
camera_scale_y = 1;
camera_view_width = 640;
camera_view_height = 480;
camera_shake_i = 0;
camera_decrease_i = 1;
camera_angle = 0;
camera_target = noone;
camera_previous_target = noone;
//camera angle is bugged when enabled, so don't set camera_angle to be non-zero if enabled
camera_enable_z = false;
// Set up 3D camera
camDist	= -240;
camFov	= 90;
camAsp	= camera_view_width / camera_view_height;
camXDisplace = 0;
camYDisplace = 0;

// Rotation
camAngleXRaw = 90;
camAngleYRaw = 0;
camAngleX = camAngleXRaw;
camAngleY = camAngleYRaw;
camAngleXShake = 0;
camAngleYShake = 0;

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

RGBShake = 5;
RGBDecrease = 1;
RGBSurf = -1;
RGBShakeMethod = 0;

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

//Effects
shader_enable_corner_id(true);
GradientSurf = -1;

global.sur_list = ds_list_create();
CutScreenSurface = surface_create(640, 480);