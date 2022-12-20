event_inherited();
enemy_name = "Sans";
enemy_act = ["Check", "Heal"];
enemy_act_text = ["Sans[delay,100] 2650 ATK 2650 DEF[delay,500]\n  You don't know what he's up to.", "You Healed."];
enemy_act_function[1] = function()
{
	global.hp += 999;
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
	[spr_sans_slam_hor],
	[spr_sans_slam_ver],
	[sprOSTBodyLeft],
	[spr_sans_slam_ver],
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

Set_BoardSize(75, 75, 75, 75, 0);
oSoul.visible = false;

Battle_SetTurnTime(
[
	500,
	120,
]
);
Battle_SetTurnBoardSize(
[
	[75, 75, 75, 75],
	[70, 70, 70, 70],
]);

LoadEnemyTextFromFile("OSTSans.txt");
ButtonSprites("OST");
with oBattleController
{
	allow_run = false;
	button_color_target = [
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]],
						[[255, 255, 255], [255, 255, 0]]
					  ];
}
spare_function = function() {global.hp = 0;}


global.data.name = "Chara";
global.data.lv = 20;
global.hp_max = 99;
global.hp = 99;
global.kr_activation = false;
global.inv = 1;
global.assign_inv = 1;
global.damage = 2;
global.item = [0];
global.RGBBlaster = 1;