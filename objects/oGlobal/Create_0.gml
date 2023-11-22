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

RGBShake = 0;
RGBDecrease = 1;
RGBSurf = new Canvas(640, 480);
RGBShakeMethod = 0;

Song =  {};
with Song
{
	Activate = false;
	Name = "";
	Dist = -20;
	Time = 0;
};

Fade = {};
with Fade
{
	Method = FADE.DEFAULT;
	Activate =
	[
		[false, 0, 0],
		[false, 0, 0],
		[false, 0, 0, 32],
	];
	Timer = 0;
};
FadeTime = 0;

Naming = {};
with Naming
{
	Enabled = true;
	Allowed = true;
	Named = false;
	State = 1
}

Border = {};
with Border
{
	Enabled = false;
	Sprite = -1;
	SpritePrevious = -1;
	Alpha = 1;
	AlphaPrevious = 0;
	//Whether the border is the game itself
	AutoCapture = false;
	//Whether the border is blurred, if so how much
	Blur = 0;
	__BlurShaderSize = shader_get_uniform(shdGaussianBlur, "size");
}

#region Effects
shader_enable_corner_id(true);
GradientSurf = new Canvas(640, 480);
global.sur_list = ds_list_create();
CutScreenSurface = undefined;
CutLineStart = shader_get_uniform(shdCutScreen, "u_lineStart");
CutLineEnd = shader_get_uniform(shdCutScreen, "u_lineEnd");
CutSide = shader_get_uniform(shdCutScreen, "u_side");
#endregion