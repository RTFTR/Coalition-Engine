function Initialize()
{
	randomize()
	
	global.name = "Chara";
	global.lv = 20;
	
	global.hp = 1;
	global.hp_max = 99;
	global.player_attack = 10;
	global.player_attack_boost = 0;
	global.player_def = 10;
	global.player_def_boost = 0;
	global.kr = 0;
	global.kr_activation = false;
	global.last_dmg_time = 0;
	global.spd = 2; // Speed
	global.inv = 2; // Invincibility frames
	global.item = [];
	global.item_heal_override_kr = false; //Does kr reduce when max heal or not
	
	global.battle_encounter = 0;
	
	global.text_face = 0
	global.text_emotion = 0
	
	global.font_damage = 
	{
		dmg : font_add_sprite_ext(spr_damage, "0123456789-+.e", true, 2)
	}
}