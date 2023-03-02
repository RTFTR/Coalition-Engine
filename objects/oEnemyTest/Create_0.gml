event_inherited();
enemy_name = "Sans";
enemy_act = ["Check", "Heal"];
enemy_act_text = ["Sans[delay,100] 2650 ATK 2650 DEF[delay,500]\n  You don't know what he's up to.", "You Healed."];
enemy_act_function[1] = function()
{
	global.hp = global.hp_max - global.kr;
	audio_play(snd_item_heal);
}

enemy_sprites =
[
	sprOSTLegs,
	sprOSTBody,
	sprOSTHead,
];
enemy_sprite_draw_method =
[
	"ext",
	"ext",
	"ext",
];
enemy_sprite_scale = [
	[2, 2],
	[2, 2],
	[2, 2],
];
enemy_sprite_pos =
[
	[0, 0],
	[0, -50],
	[0, -115],
];
enemy_sprite_wiggle = [
	["sin", 0, 0, 0, 0],
	["sin", .1, .2, 2.1, 1.4],
	["sin", .1, .2, 1.7, 1.2],
];

SlamSprites = [
	[sprOSTBodyRight],
	[sprOSTBodyUp],
	[sprOSTBodyLeft],
	[sprOSTBodyDown],
];
SlamSpriteTargetIndex = [
	[0, 1, 1, 1, 2],
	[0, 1, 2, 3, 3],
	[0, 1, 1, 1, 2],
	[0, 1, 2, 3, 3],
];

dialog_y_from_top = 20;
dialog_size[2] += 15;
dialog_size[3] += 85;
dialog_box_color = make_color_rgb(183, 190, 182);

dodge_method = function()
{
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y", damage_y, damage_y - 30);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 40, 20, "damage_y", damage_y - 30, damage_y);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 25, "x", x, x - dodge_to);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 55, 25, "x", x - dodge_to, x);
}

oBoard.image_blend = make_color_rgb(47, 47, 47);

Enemy_SetHPStats(680, 680, 0);
damage = irandom_range(300,500);
is_dodge = true;
begin_at_turn = true;
BGM = audio_create_stream("Music/MusOST1.ogg");
wiggle = false;

Set_BoardSize(75, 75, 75, 75, 0);
oSoul.visible = false;

Battle_SetTurnTime(
[
	500,
	910,
	1300,
]
);
Battle_SetTurnBoardSize(
[
	[75, 75, 75, 75],
	[30, 30, 30, 30],
	[90, 40, 65, 65],
]);

LoadTextFromFile("OSTSans.txt");
ButtonSprites("OST");
with oBattleController
{
	activate_heal = [0, 1, 0, 0];
	allow_run = false;
	button_color_target = [
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]]
					  ];
	button_color = [[255, 255, 255], [255, 255, 255], [255, 255, 255], [255, 255, 255]];
}
spare_function = function() {global.hp = 0;}

TurnData.HealAttacks[0] = 
function()
{
	if time == 1
		Set_BoardSize(70, 70, 70, 70);
	if time >= 30
	{
		var dir = time * 3.5;
		Blaster_Circle([320,320], [600, 150], [dir, dir], [dir, dir + 180], [1, 2], [30, 20, 20]);
	}
}
TurnData.HealTime = [600];

global.data.name = "Chara";
global.data.lv = 20;
global.hp_max = 99;
global.hp = 99;
global.kr_activation = false;
global.inv = 1;
global.assign_inv = 1;
global.damage = 2;
global.item = [0];
global.RGBBlaster = false;

window_set_caption("OverSave Tale - Sans Fight");

base_bone_col = make_color_rgb(183, 190, 182);