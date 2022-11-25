if instance_exists(oBoard)
	depth = oBoard.depth - oBattleController.depth - 1;
image_speed = 0;
image_blend = c_red;
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

function BasicMovement() {
	
	var h_spd = input_check("right") - input_check("left");
	var v_spd = input_check("down") - input_check("up");

	var move_spd = global.spd / (input_check("cancel") + 1);
	move_x = h_spd * move_spd;
	move_y = v_spd * move_spd;
	var _angle = image_angle;

	if moveable {
		x += lengthdir_x(move_x, _angle);
		y += lengthdir_y(move_y, _angle - 90);
	}
	image_angle = _angle;
}

fall_spd = 0;
fall_grav = 0;

on_ground = false;
on_ceil = false;
on_platform = false;

slam = false;

moveable = true;

allow_outside = false;

timer = 0;

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