//Data
Camera_Scale(1, 1);
enemy_name = "";
enemy_act = ["", "", "", "", ""];
enemy_act_text = ["", "", "", "", ""];
enemy_act_function = [-1, -1, -1, -1, -1, -1];
enemy_hp_max = 100;
enemy_hp = 100;
_enemy_hp = 100;
enemy_draw_hp_bar = 1;
enemy_defense = 1;
enemy_in_battle = true;
is_boss = false;
Exp_Give = 100;
Gold_Give = 100;
state = 0;
begin_at_turn = false;
end_turn_menu_text = [
	"turn 2 text",
	"turn 3 text",
];

//Temp var
enemy_sprites = [
	spr_sans_legs,
	spr_sans_body,
	spr_sans_head,
];
enemy_sprite_index = [0, 0, 0, 0];
enemy_sprite_scale = [
	[1, 1],
	[1, 1],
	[1, 1],
];
enemy_sprite_draw_method = [
	"pos",
	"ext",
	"ext",
]
enemy_total_height = 0;
enemy_max_width = 0
var i = 0;
repeat(array_length(enemy_sprites))
{
	enemy_total_height += sprite_get_height(enemy_sprites[i]) * enemy_sprite_scale[i, 1];
	enemy_max_width = max(sprite_get_width(enemy_sprites[i]) * enemy_sprite_scale[i, 0],
							enemy_max_width);
	++i;
}
enemy_sprite_pos = [
	[-47, -50, 47, -50, 47, 0, -47, 0],
	[0, -40],
	[0, -75],
];
// Sining method, multiplier, multiplier, rate, rate
enemy_sprite_wiggle = [
	["sin", .1, .2, 2.1, 1.3],
	["sin", .1, .2, 2.1, 1.4],
	["sin", .1, .2, 1.7, 1.2],
];
wiggle = 1;
wiggle_timer = 0;
dialog_y_from_top = 50;
//Slamming (If needed)
SlamDirection = DIR.DOWN;
Slamming = false;
SlamTimer = 0;
SlamSprites = [
	[spr_sans_slam_hor],
	[spr_sans_slam_ver],
	[spr_sans_slam_hor],
	[spr_sans_slam_ver],
];
SlamSpriteIndex = 0;
SlamSpriteTargetIndex = [
	[1, 0, 0, 1, 2],
	[1, 0, 0, 1, 2],
	[0, 1, 2, 2, 2],
	[0, 1, 2, 2, 2],
];
SlamSpriteNumber = 1;

dodge_method = function()
{
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y", damage_y, damage_y - 30);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 20, 20, "damage_y", damage_y - 30, damage_y);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 25, "x", x, x - dodge_to);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 35, 25, "x", x - dodge_to, x);
}

//Dust
ContainsDust = 1;

//Particles aren't used because if a lot of particles are created then the CPU will be abused
//And the dust amount is on average at least a couple hundred, so drawing in arrays are better
if ContainsDust {
	dust_height = 0;
	dust_amount = enemy_total_height * enemy_max_width / 6;
	//Using array create functions to speed up loading time because it's easy to have over 2000 values in the arrays
	var _f = function()
	{
		var dust_speed = random_range(1, 3),
			dust_direction = random_range(55, 125);
		return [dust_speed * dcos(dust_direction),
				dust_speed * -dsin(dust_direction)];
	}
	dust_displace = array_create_ext(dust_amount, _f);
	_f = function()
	{
		return random_range(60, 120);
	}
	dust_life = array_create_ext(dust_amount, _f);
	dust_alpha = array_create(dust_amount, 1);
	_f = function()
	{
		return random(360);
	}
	dust_angle = array_create_ext(dust_amount, _f);
	_f = function()
	{
		return random_range(1, -1);
	}
	dust_rotate = array_create_ext(dust_amount, _f);
	i = 0;
	repeat(dust_amount)
	{
		dust_pos[i] = [random_range(-enemy_max_width, enemy_max_width) / 2 + x,
					   y - enemy_total_height + (i * 6 / enemy_max_width)];
		i++;
	}
	dust_surface = -1;
	dust_being_drawn = false;
}
dust_speed = 60;

//Dialog
dialog_size = [20, 65, 0, 190]; // UDLR
dialog_size[3] = 80;
dialog_dir = DIR.LEFT;
dialog_text = [""];
dialog_box_color = c_white;
dialog_at_mid_turn = false;

function Battle_EnemyDialog(turn, text)
{
	if !is_array(text) dialog_text[turn] = text;
	else dialog_text = text;
	dialog_init(dialog_text[oBattleController.battle_turn]);
}

function dialog_init(text = "", force_false = false)
{
	dialog = "[c_black][/f][fnt_sans]";
	dialog += text;
	scribble_typists_add_event("skippable", textsetskippable);
	scribble_typists_add_event("SpriteSet", setsprite);
	scribble_typists_add_event("flash", flash);
	text_writer = scribble(dialog)
		.wrap(dialog_size[2] + dialog_size[3] - 15, dialog_size[0] + dialog_size[1] - 15)
	if text_writer.get_page() != 0 text_writer.page(0);
	if state == 2 dialog_at_mid_turn = !force_false;
}
dialog_init(dialog_text[0]);
dialog_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_txtSans, 1, 1, " ^!.?,:/\\|*")

//Under Attack
is_being_attacked = false;
is_dodge = false;
is_miss = false;
dodge_to = choose(-150, 150);
attack_time = 0;
attack_end_time = 60;
draw_damage = false;
damage_y = y - enemy_total_height / 2 - 60;
damage = 0;
damage_color = c_red;
bar_width = 120;
bar_retract_speed = 0.6;

//Death
death_time = 0;
is_dying = false;
died = false;

//Spare
enemy_is_spareable = true;
is_being_spared = false;
spare_end_begin_turn = false;
is_spared = false;
spare_function = -1;

//Turn
function Battle_SetTurnTime()
{
	turn_time = argument0;
}

function Battle_SetTurnBoardSize()
{
	board_size = argument0;
}


turn_time = [300];

board_size = [
	[70, 70, 70, 70],
];

TurnData = 
{
	Functions : [],
	AttackDelay : [],
	AttackRepeat : [],
	AttackRepeatCount : [],
	AttackInterval : [],
	AttacksLoaded : false,
	HealAttacks : [-1],
	HealTime : [100],
	HealNum : 0,
	IsHeal : false,
}

start = 1;
time = -1;

base_bone_col = c_white;