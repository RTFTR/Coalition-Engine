if instance_exists(oBoard)
	depth = oBoard.depth - oBattleController.depth - 1;
image_speed = 0;
Blend = c_red;
image_blend = Blend;
draw_angle = 0;

dir = DIR.DOWN;

follow_board = false;
global.inv = 0;
global.assign_inv = 60;		// Sets the inv time for soul
global.deadable = true;

EffectS = part_system_create();
part_system_depth(EffectS, depth);
EffectT = part_type_create();
part_type_sprite(EffectT, sprite_index, 0, 0, 0);
part_type_life(EffectT, 1/0.035,1/0.035);
part_type_size(EffectT, 1, 1, 0.15, 0);
part_type_alpha2(EffectT, 1, 0)

mode = SOUL_MODE.RED;

move_x = 0;
move_y = 0;

///@param {bool} Horizontal	Enable horzontal movement (Default true)
///@param {bool} Vertical	Enable vertical movement (Default true)
///@param {bool} Fast_Diagonal	Whether diagonal movements will be faster (as in Pyth. Theorem) (Default false)
function BasicMovement(hor = true, ver = true, fast = false) {
	if !IsGrazer
	{
		var h_spd = CHECK_HORIZONTAL,
			v_spd = CHECK_VERTICAL,
			move_spd = global.spd / (input_check("cancel") + 1),
			_angle = image_angle;
		if fast and h_spd != 0 and v_spd != 0 move_spd *= sqrt(2);
		move_x = h_spd * move_spd;
		move_y = v_spd * move_spd;

		if moveable {
			if instance_exists(oBoardCover)
			{
				move_and_collide(lengthdir_x(move_x, _angle), lengthdir_y(move_y, _angle - 90), oBoardCover, move_spd * 10);
			}
			else
			{
				if hor
					x += lengthdir_x(move_x, _angle);
				if ver
					y += lengthdir_y(move_y, _angle - 90);
			}
		}
		image_angle = _angle;
	}
}

//Blue soul variables
fall_spd = 0;
fall_grav = 0;

on_ground = false;
on_ceil = false;
on_platform = false;

slam = false;

moveable = true;

allow_outside = false;

timer = 0;

//Green soul variables
ShieldDrawAngle = [0, 0];
ShieldTargetAngle = [0, 0];
ShieldLen = [18, 18];
ShieldAlpha = [0, 0];
ShieldInput = 
[
	[vk_right, vk_up, vk_left, vk_down],
	[ord("D"), ord("W"), ord("A"), ord("S")]
];
ShieldColor = [c_blue, c_red];
ShieldHitCol = [c_red, c_yellow];
ShieldAmount = 2;
global.Autoplay = true;
ShieldParticleSystem = part_system_create();
ShieldParticleType = part_type_create();
part_type_life(ShieldParticleType, 10, 30);
part_type_direction(ShieldParticleType, 0, 360, 0, 0);
part_type_speed(ShieldParticleType, 2, 4, 0, 0);
part_type_alpha2(ShieldParticleType, 1, 0);
part_type_sprite(ShieldParticleType, sprPixel, 0, 0, 0);

//Purple soul variables
Purple =
{
	Mode : 0,
	VLineAmount : 3,
	CurrentVLine : 1,
	HLineAmount : 3,
	CurrentHLine : 1,
	ForceAlpha : 0,
	XTarget : 320,
	YTarget : 320,
}

//Grazing
IsGrazer = false;
//Grazer = -1;
//GrazeObj = noone;
//GrazeAlpha = 0;
//GrazeTimer = 0;

if (!instance_exists(oReplayer) && global.RecordReplay && global.ReplayMode == "Record")
	RecordReplay();
