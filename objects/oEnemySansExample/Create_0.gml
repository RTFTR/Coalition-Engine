event_inherited();
Enemy_SetName("Sans");
Enemy_SetActTexts(
	["Check", "sans 1", "sans2", "sans3", "sans4"],
	["funny skeleton man[delay,1000] 1 ATK 1 DEF", "sans 1 text", "sans2twxt", "sans3text", "sans4text"]
	);
Enemy_SetHPStats(100, 50);
Enemy_SetReward(100, 100);
default_font = "fnt_sans";
default_sound = snd_txtSans;
is_dodge = true;
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
];
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

SlammingEnabled = true;
SlamSprites = [
	[spr_sans_slam_hor],
	[spr_sans_slam_ver],
	[spr_sans_slam_hor],
	[spr_sans_slam_ver],
];
SlamSpriteTargetIndex = [
	[1, 0, 0, 1, 2],
	[1, 0, 0, 1, 2],
	[0, 1, 2, 2, 2],
	[0, 1, 2, 2, 2],
];

dialog_size[3] = 80;

dodge_to = choose(-150, 150);
dodge_method = function()
{
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y>", damage_y - 30);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 20, 20, "damage_y", damage_y - 30, damage_y);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 25, "x>", x - dodge_to);
	TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 35, 25, "x", x - dodge_to, x);
}

surf = -1;
//Effect_Shader(shdBlueReduce, ["reduceAmount", [0.25]]);

var text;
for(var i = 0; i < 12; i++)
{
	text = LoadTextFromFile("SansTest2.txt", 1, "@" + string(i));
	global.BattleData.EnemyDialog(self, i, text);
}

SetAttack(0, function() {
	global.BattleData.EnemyDialog(self, global.BattleData.Turn() + 1, "override")
	if time == 60 end_turn();
});

SetAttack(1, function() {
	if time == 60 global.BattleData.SetBoardSize(8, 8, 8, 8);
	if time == 120 end_turn();
});

PreAttackFunction(0, function() { show_message("hi") } );
PostAttackFunction(0, function() { show_message("hi") } );