if instance_exists(oBoard)
	depth = oBoard.depth - oBattleController.depth - 1;
image_speed = 0;
Blend = c_red;
r = 255;
g = 0;
b = 0;
function ChangeColor() {
	TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 15, "r", r, color_get_red(Blend));
	TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 15, "g", g, color_get_green(Blend));
	TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 15, "b", b, color_get_blue(Blend));
}
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

function BasicMovement(hor = true, ver = true) {
	if !IsGrazer
	{
		var h_spd = input_check("right") - input_check("left"),
			v_spd = input_check("down") - input_check("up"),
			move_spd = global.spd / (input_check("cancel") + 1),
			_angle = image_angle;
		move_x = h_spd * move_spd;
		move_y = v_spd * move_spd;

		if moveable {
			if hor
				x += lengthdir_x(move_x, _angle);
			if ver
				y += lengthdir_y(move_y, _angle - 90);
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
ShieldDrawAngle = 0;
ShieldTargetAngle = 0;
ShieldLen = 18;
ShieldIndex = 0;
global.Autoplay = true;
global.Autoplay = 0;
function DestroyArrow(obj) {
	audio_play(snd_ding);
	ShieldIndex = 2;
	instance_destroy(obj);
}

//Purple soul variables
Purple =
{
	Mode : 1,
	VLineAmount : 3,
	CurrentVLine : 1,
	HLineAmount : 3,
	CurrentHLine : 1,
	ForceAlpha : 0,
	XTarget : 320,
	YTarget : 320,
}

//Grazing
Grazer = -1;
GrazeObj = noone;
IsGrazer = false;
GrazeAlpha = 0;
GrazeTimer = 0;