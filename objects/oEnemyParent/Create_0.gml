//Data
Camera_Scale(1, 1);
enemy_name = "";
enemy_act = ["", "", "", "", ""];
enemy_act_text = ["", "", "", "", ""];
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
for (var i = 0, n = array_length(enemy_sprites); i < n; ++i)
{
	enemy_total_height += sprite_get_height(enemy_sprites[i]) * enemy_sprite_scale[i, 1];
	enemy_max_width = max(sprite_get_width(enemy_sprites[i]) * enemy_sprite_scale[i, 0],
							enemy_max_width);
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

//Dust (AUTOMATICALLY DISABLED)
if !variable_instance_exists(id, "ContainsDust")
	ContainsDust = 0;
if ContainsDust {
	dust_height = 0;
	dust_amount = enemy_total_height * enemy_max_width;
	for (var i = 0; i < dust_amount; i += 6)
	{
		dust_pos[i] = [random_range(-enemy_max_width, enemy_max_width) / 2 + x,
					   round(y - enemy_total_height + (i / enemy_max_width))];
		dust_direction[i] = random_range(55, 125);
		dust_speed[i] = random_range(1, 3);
		dust_displace[i] = [lengthdir_x(dust_speed[i], dust_direction[i]),
							lengthdir_y(dust_speed[i], dust_direction[i])];
		dust_life[i] = random_range(60, 120);
		dust_alpha[i] = 1;
	}
	dust_speed = 30;
	dust_surface = -1;
	dust_being_drawn = false;
}

//Dialog
dialog_size = [20, 65, 0, 190]; // UDLR
dialog_size[3] = 80;
dialog_dir = DIR.LEFT;
dialog_text = [""];

function Battle_EnemyDialog(turn, text)
{
	if !is_array(text) dialog_text[turn] = text;
	else dialog_text = text;
	dialog_init(dialog_text[oBattleController.battle_turn]);
}

function dialog_init(text = "")
{
	dialog = "[c_black][/f][fnt_sans]";
	dialog += text;
	text_writer = scribble(dialog)
		.wrap(dialog_size[2] + dialog_size[3] - 10, dialog_size[0] + dialog_size[1] - 10)
	if text_writer.get_page() != 0 text_writer.page(0);
}
dialog_init(dialog_text[0]);
dialog_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_txtSans, 1, 1, " ^!.?,:/\\|*")

//Under Attack
is_being_attacked = false;
is_dodge = false;
dodge_to = choose(-150, 150);
attack_time = 0;
attack_end_time = 60;
draw_damage = false;
damage_y = y - enemy_total_height + dialog_y_from_top;
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

//Turn
function end_turn()
{
	var turn = oBattleController.battle_turn - 1,
		end_turn_menu_text = [
	"turn 2 text",
	"turn 3 text",
	];
	if array_length(end_turn_menu_text) >= (turn + 1) and turn > -1
		Battle_SetMenuDialog(end_turn_menu_text[turn]);
	else {
		with oBattleController
		{
			menu_text_typist.reset();
			text_writer.page(0);
			Battle_SetMenuDialog(default_menu_text);
		}
	}
	with oBattleController
	{
		battle_state = 0;
		menu_state = 0;
		//Effect removal
		if Effect.SeaTea
		{
			Effect.SeaTeaTurns--;
			if !Effect.SeaTeaTurns
			{
				Effect.SeaTeaTurns = 4;
				Effect.SeaTea = false;
				global.spd /= 2;
			}
		}
	}
	//Armor healing
	if (turn % 2) == 1
	{
		if global.data.DefenseItem == "Temmie Armor" or
			global.data.DefenseItem == "Stained Apron"
		{
			global.hp++;
			audio_play(snd_item_heal);
		}
	}
	Set_BoardSize();
	oBoard.image_angle %= 360;
	Set_BoardAngle();
	Set_BoardPos();
	with oSoul
		draw_angle = (mode == SOUL_MODE.YELLOW ? 180 : 0);
	with oBulletBone
		if retract_on_end
		{
			at_turn_end = true;
			destroy_on_turn_end = false;
			can_hurt = 0;
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 25, "length", length, 0);
			alarm[1] = 25;
		}
	with oBulletParents
		if destroy_on_turn_end instance_destroy();
	state = 0;
	draw_damage = false;
	time = -1;
	if array_length(TurnData.TimeSources) > turn and turn > 0
		for (var i = 0, n = array_length(TurnData.TimeSources[turn]); i < n; ++i)
			time_source_destroy(TurnData.TimeSources[turn, i]);
	Enemy_NameUpdate();
}


turn_time = [300, 120];

board_size = [
	[70, 70, 70, 70],
	[70, 70, 130, 130],
];

TurnData = 
{
	TimeSources : [],
	TSDelay : [],
	TSRep : [],
	TSRepC : [],
	TSInterval : [],
	AttacksLoaded : false,
}

start = 1;
time = -1;

function Battle_SetTurnTime()
{
	turn_time = argument0;
}

function Battle_SetTurnBoardSize()
{
	board_size = argument0;
}

function RemoveEnemy()
{
	if instance_exists(oBattleController)
		with oBattleController {
			var enemy_slot = other.x / 160 - 1;
			enemy[enemy_slot] = noone;
			enemy_draw_hp_bar[enemy_slot] = 0;
		}
}