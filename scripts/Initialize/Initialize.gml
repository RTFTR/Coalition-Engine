function Initialize()
{
	randomize();

	global.player_attack_boost = 0;
	global.player_def_boost = 0;
	global.player_inv_boost = 0;
	global.kr = 0;
	global.kr_activation = false;
	global.bar_count = 1;
	global.last_dmg_time = 0;
	global.spd = 2; // Speed
	global.inv = 2; // Invincibility frames
	global.item_heal_override_kr = true; //Does kr reduce when max heal or not
	global.item_uses_left = [1,1,1,1,1,1];
	global.item_uses_left[ITEM.PIE] = 2;
	global.SpareTextColor = (!irandom(100) ? "[c_fuchsia]" : "[c_yellow]");
	global.BossFight = false;
	global.Kills = 0;
	
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
	
	var Cell_Preset = [1,2,0,0,0,0,0,0];
	for (var i = 0; i < 8; i++)
	global.SaveFile[? ("Cell "+string(i))] = Cell_Preset[i];
	
	var Box_Preset =
	[
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// OW Box
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// Dimensional Box A
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]		// Dimensional Box B
	];
	for (var i = 0; i < 3; i++)
		for (var ii = 0; ii < 8; ii++)
			global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
	
	global.SaveFile[? "Kills"] = 0;
	
	if !file_exists("Data.dat") Save_Datas(); else Load_Datas();
	
	global.name = global.SaveFile[? "Name"];
	global.lv = global.SaveFile[? "LV"];
	global.hp = global.SaveFile[? "HP"];
	global.hp_max = global.SaveFile[? "Max HP"];
	global.Gold = global.SaveFile[? "Gold"];
	global.Exp = global.SaveFile[? "EXP"];
	global.AttackItem = global.SaveFile[? "Wep"];
	global.DefenseItem = global.SaveFile[? "Arm"];
	global.Kills = global.SaveFile[? "Kills"];
	ConvertItemNameToStat();
	Player_GetBaseStats();
	for (var i = 0; i < 8; i++)
	{
		global.item[i] = global.SaveFile[? ("Item "+string(i))];
		global.cell[i] = global.SaveFile[? ("Cell "+string(i))];
	}
	for (var i = 0; i < 10; i++)
		for (var ii = 0; ii < 3; ii++)
			global.Box[ii, i] = global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
	
	global.Settings = ds_map_create();
	global.Settings[? "Volume"] = 100;
	
	if !file_exists("Settings.dat") Save_Settings(); else Load_Settings();
	
	global.Volume = global.Settings[? "Volume"];
	
	global.battle_encounter = 0;
	
	global.text_face = 0;
	global.text_emotion = 0;
}