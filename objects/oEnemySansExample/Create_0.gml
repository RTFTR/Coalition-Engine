event_inherited();
EnemyData.SetName(self, "Sans");
EnemyData.SetAct(self, 0, "Check", "funny skeleton man[delay,1000] 1 ATK 1 DEF");
EnemyData.SetAct(self, 1, "sans 1", "sans 1 text");
EnemyData.SetAct(self, 2, "sans2", "sans2twxt");
EnemyData.SetAct(self, 3, "sans3", "sans3text");
EnemyData.SetAct(self, 4, "sans4", "sans4text");
EnemyData.SetHPStats(self, 100, 50);
EnemyData.SetReward(self, 100, 100);
enemy_is_spareable = true;
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
	TweenFire(id, "oQuad", 0, false, 0, 20, "damage_y>", damage_y - 30);
	TweenFire(id, "oQuad", 0, false, 20, 20, "damage_y", damage_y - 30, damage_y);
	TweenFire(id, "oQuad", 0, false, 0, 25, "x>", x - dodge_to);
	TweenFire(id, "oQuad", 0, false, 35, 25, "x", x - dodge_to, x);
}

surf = -1;
//Effect_Shader(shdBlueReduce, ["reduceAmount", [0.25]]);

var text;
for(var i = 0; i < 12; i++)
{
	text = LoadTextFromFile("SansTest2.txt", 1, "@" + string(i));
	BattleData.EnemyDialog(self, i, text);
}

SetAttack(0, function() {
	if time == 1
	{
		with oBoard
		{
			//TweenEasyRotate(0, 45, 0, 30, "o")
			//ConvertToVertex();
			//var index = InsertPolygonPoint(4, 320, 255);
			//TweenFire(id, "oSine", 0, 0, 0, 60, TPArray(Vertex, index + 1), 255, 100);
		}
	}
	BattleData.EnemyDialog(self, BattleData.Turn() + 1, "override")
	//if time == 160 end_turn();
});

SetAttack(1, function() {
	if time == 60 Board.SetSize(8, 8, 8, 8);
	if time == 120 end_turn();
});

AddGPU(id, ev_draw, bm_max, function() {
	draw_gradient_ext(0, 480, 640, 240, 0, c_red);
});
AddGPU(id, ev_draw, bm_max, function() {
	draw_gradient_ext(640, 480, 480, 160, 90, c_aqua);
});
AddGPU(id, ev_draw, bm_max, function() {
	draw_gradient_ext(640, 0, 640, 240, 180, c_yellow);
});
var tmp =
AddGPU(id, ev_draw, bm_max, function() {
	draw_gradient_ext(0, 0, 480, 160, -90, c_white);
});
GPURemove(tmp);
AddGPUExt(id, ev_draw, bm_inv_dest_color, bm_zero, function() {
	draw_circle(mouse_x, mouse_y, 50, false);
});