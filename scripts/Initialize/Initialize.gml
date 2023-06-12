function initialize()
{
	show_debug_message("This is Coalition Engine " + ENGINE_VERSION);
	//Set to true when releasing your game
	gml_release_mode(true);
	randomize();
	
	//Soul position (Gameover usage)
	global.soul_x = 320;
	global.soul_y = 320;
	
	//Debugging (Engine usage)
	global.debug = false;
	global.show_hitbox = 0;
	global.timer = 0;
	
	//Sets whether slam does damage
	global.slam_damage = false;
	
	//Sets Whether Blasters cause RGB splitting effect
	global.RGBBlaster = false;
	
	//Replaying uses
	global.ReplaySaveFileName = "";
	global.ReplayLoadFileName = "";
	global.ReplayMode = "Record";
	global.RecordReplay = false;
	
	//BPM of the song (Rhythm usage)
	global.SongBPM = 0;
	
	//Sets whether the current text is skippable (Engine usage)
	global.TextSkipEnabled = true;
	
	//Player stats
	global.player_attack_boost = 0;
	global.player_def_boost = 0;
	global.player_inv_boost = 0;
	
	//Battle stats
	global.kr = 0;
	global.kr_activation = false;
	global.damage = 1;
	global.krdamage = 1;
	global.bar_count = 1;
	global.last_dmg_time = 0;
	global.spd = 2; // Speed
	global.inv = 2; // Invincibility frames
	
	//Grazing
	global.EnableGrazing = false;
	global.TP = 0;
	
	//Items
	global.item_heal_override_kr = true; //Does kr reduce when max heal or not
	global.item_uses_left = array_create(ITEM_COUNT + 1, 1);
	global.item_uses_left[ITEM.PIE] = 2;
	
	//Spare
	global.SpareTextColor = (!irandom(100) ? "[c_fuchsia]" : "[c_yellow]");
	
	//Whether the current fight is a boss fight or not (Engine usage)
	global.BossFight = false;
	
	//Save file (Free to edit)
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
	var Item_Preset = [ITEM.PIE, ITEM.INOODLES, ITEM.STEAK, ITEM.SNOWP, ITEM.SNOWP,
						ITEM.LHERO, ITEM.LHERO, ITEM.SEATEA],
		Cell_Preset = [1, 2, 0, 0, 0, 0, 0, 0],
		Box_Preset =  //Insert the items manually
		[
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// OW Box
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// Dimensional Box A
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]		// Dimensional Box B
		];
	for (var i = 0; i < 8; i++) {
		if i < 3
			for (var ii = 0; ii < 8; ii++)
				global.SaveFile[? "Box " + string(i) + "_" + string(ii)];
		global.SaveFile[? ("Cell " + string(i))] = Cell_Preset[i];
		global.SaveFile[? ("Item " + string(i))] = Item_Preset[i];
	}
	
	//Save file Save/Loading
	if !file_exists("Data.dat")
		ds_map_secure_save(global.SaveFile, "Data.dat");
	else
		global.SaveFile = ds_map_secure_load("Data.dat");
	
	
	global.hp =			global.SaveFile[? "HP"];
	global.hp_max =		global.SaveFile[? "Max HP"];
	global.data =
	{
		name :			global.SaveFile[? "Name"],
		lv :			global.SaveFile[? "LV"],
		Gold :			global.SaveFile[? "Gold"],
		Exp :			global.SaveFile[? "EXP"],
		AttackItem :	global.SaveFile[? "Wep"],
		DefenseItem :	global.SaveFile[? "Arm"],
		Kills :			global.SaveFile[? "Kills"],
	}
	ConvertItemNameToStat();
	Player_GetBaseStats();
	
	for (var i = 0; i < 10; i++) {
		for (var ii = 0; ii < 3; ii++)
			global.Box[ii, i] = global.SaveFile[? "Box " + string(i) + "_" + string(ii)];
		if i < 8
		{
			global.item[i] = global.SaveFile[? ("Item " + string(i))];
			global.cell[i] = global.SaveFile[? ("Cell " + string(i))];
		}
	}
	
	//Custom Settings
	global.Settings = ds_map_create();
	global.Volume = 100;
	global.CompatibilityMode = false;
	global.ShowFPS = false;
	//Input keys are defined at __input_config_profiles_and_default_bindings
	
	if !file_exists("Settings.ini") save_file(FILE.SETTINGS); else save_file(FILE.SETTINGS);
	
	global.TempData = ds_map_create();
	
	//Sets the current battle encounter ID
	global.battle_encounter = 0;
	
	//Sets the current Overworld dialog sprite (Currently unused)
	global.text_face = 0;
	global.text_emotion = 0;
	
	//Particles
	global.TrailS = part_system_create();
	global.TrailP = part_type_create();
	part_type_life(global.TrailP, 30, 30);
	part_type_alpha2(global.TrailP, 1, 0);
	
	global.deactivatedInstances = ds_list_create();
	global.trueInstanceCache = ds_list_create();
}