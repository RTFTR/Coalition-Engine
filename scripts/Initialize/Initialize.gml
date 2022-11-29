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
	global.EnableGrazing = true;
	global.EnableGrazing = false;
	global.TP = 0;
	global.item_heal_override_kr = true; //Does kr reduce when max heal or not
	for(var i = 0; i <= ITEM_COUNT; ++i)
		global.item_uses_left[i] = 1;
	global.item_uses_left[ITEM.PIE] = 2;
	global.SpareTextColor = (!irandom(100) ? "[c_fuchsia]" : "[c_yellow]");
	global.BossFight = false;
	global.Kills = 0;
	
	global.SaveFile = ds_map_create();
	global.SaveFile[? "Name"] =			"Chara";
	global.SaveFile[? "LV"] =			20;
	global.SaveFile[? "HP"] =			99;
	global.SaveFile[? "Max HP"] =		99;
	global.SaveFile[? "Gold"] =			0;
	global.SaveFile[? "EXP"] =			0;
	global.SaveFile[? "Wep"] =			"Stick";
	global.SaveFile[? "Arm"] =			"Bandage";
	global.SaveFile[? "Kills"] =		0;
	var Item_Preset = [1,2,3,4,4,4,5,6];
	var Cell_Preset = [1,2,0,0,0,0,0,0];
	var Box_Preset =  //Insert the items
	[
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// OW Box
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// Dimensional Box A
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]		// Dimensional Box B
	];
	for (var i = 0; i < 8; i++) {
		if i < 3
			for (var ii = 0; ii < 8; ii++)
				global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
		global.SaveFile[? ("Cell "+string(i))] = Cell_Preset[i];
		global.SaveFile[? ("Item "+string(i))] = Item_Preset[i];
	}
	
	
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
	
	for (var i = 0; i < 10; i++) {
		for (var ii = 0; ii < 3; ii++)
			global.Box[ii, i] = global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
		if i < 8
		{
			global.item[i] = global.SaveFile[? ("Item "+string(i))];
			global.cell[i] = global.SaveFile[? ("Cell "+string(i))];
		}
	}
	
	global.Settings = ds_map_create();
	global.Volume = 100;
	
	if !file_exists("Settings.dat") Save_Settings(); else Load_Settings();
	
	global.battle_encounter = 0;
	
	global.text_face = 0;
	global.text_emotion = 0;
	
	//Particles
	global.TrailS = part_system_create();
	global.TrailP = part_type_create();
	part_type_life(global.TrailP, 30, 30);
	part_type_alpha2(global.TrailP, 1, 0);
}