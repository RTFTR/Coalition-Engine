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
camera_enable_z = false;
// Set up 3D camera
camDist	= -300;
camFov	= 90;
camAsp	= camera_get_view_width(Main_Camera) / camera_get_view_height(Main_Camera);
camXDisplace = 0;
camYDisplace = 0;

// Rotation
allowRotation = true;
camSensitivityX = 1;
camSensitivityY = 1;

camAngleXRaw = 90;
camAngleYRaw = 0;
camAngleX = camAngleXRaw;
camAngleY = camAngleYRaw;

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