function Initialize()
{
	randomize()

	global.player_attack_boost = 0;
	global.player_def_boost = 0;
	global.player_inv_boost = 0;
	global.kr = 0;
	global.kr_activation = false;
	global.bar_count = 1;
	global.last_dmg_time = 0;
	global.spd = 2; // Speed
	global.inv = 2; // Invincibility frames
	global.item_heal_override_kr = false; //Does kr reduce when max heal or not
	global.SpareTextColor = (!irandom(100) ? "[c_fuchsia]" : "[c_yellow]");
	global.BossFight = false;
	
	global.SaveFile = ds_map_create();
	global.SaveFile[? "Name"] = "Chara";
	global.SaveFile[? "LV"] = 20;
	global.SaveFile[? "HP"] = 99;
	global.SaveFile[? "Max HP"] = 99;
	global.SaveFile[? "Gold"] = 0;
	global.SaveFile[? "EXP"] = 0;
	global.SaveFile[? "Wep"] = "Stick";
	global.SaveFile[? "Arm"] = "Bandage";
	var Item_Preset = [1,2,3,4,4,4,5,5];
	for (var i = 0; i < 8; i++)
	global.SaveFile[? ("Item "+string(i))] = Item_Preset[i];
	
	if !file_exists("Data.dat") Save_Datas(); else Load_Datas();
	
	global.name = global.SaveFile[? "Name"];
	global.lv = global.SaveFile[? "LV"];
	global.hp = global.SaveFile[? "HP"];
	global.hp_max = global.SaveFile[? "Max HP"];
	global.Gold = global.SaveFile[? "Gold"];
	global.Exp = global.SaveFile[? "EXP"];
	global.AttackItem = global.SaveFile[? "Wep"];
	global.DefenseItem = global.SaveFile[? "Arm"];
	ConvertItemNameToStat();
	for (var i = 0; i < 8; i++)
	global.item[i] = global.SaveFile[? ("Item "+string(i))];
	
	global.battle_encounter = 0;
	
	global.text_face = 0
	global.text_emotion = 0
	
	global.font_damage = 
	{
		dmg : font_add_sprite_ext(spr_damage, "0123456789-+.e", true, 2)
	}
}