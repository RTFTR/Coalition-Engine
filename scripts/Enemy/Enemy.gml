function Enemy_Function_Load(encounter_number){	
	
	enemy = ds_list_create();
	enemy_name = ds_list_create();
	enemy_hp = ds_list_create();
	enemy_hp_max = ds_list_create();
	enemy_draw_hp_bar = ds_list_create();
	
	var enemy_presets=
	[
	[noone, obj_enemy_sans, obj_enemy_sans2],
	];
	var enemies
	
	for (var i = 0; i < 3; ++i)
	{
		enemies[i] = enemy_presets[encounter_number, i];
		enemy[| i] = enemies[i];
		if enemies[i] != noone
		{
			instance_create_depth(160 * (i + 1), 250, 0, enemies[i]);
			enemy_name[| i] = enemies[i].enemy_name;
			enemy_hp[| i] = enemies[i].enemy_hp;
			enemy_hp_max[| i] = enemies[i].enemy_hp_max;
			enemy_draw_hp_bar[| i] = enemies[i].enemy_draw_hp_bar;
			for(var ii = 0; ii < 6; ++ii)
			{
				enemy_act[i, ii] = enemies[i].enemy_act[ii];
				enemy_act_text[i, ii] = enemies[i].enemy_act_text[ii];
			}
			if enemies[i].is_boss = true global.BossFight = true;
		}
		else
		{
			enemy_act[i] = [""];
		}
	}
}

function Enemy_SetName(name)
{
	enemy_name = name;
}

function Enemy_SetActTexts(name, text)
{
	enemy_act = name;
	enemy_act_text = text;
}

function Enemy_SetHPStats(max_hp, current_hp = max_hp, draw_hp_bar = 1)
{
	enemy_hp_max = max_hp;
	enemy_hp = current_hp;
	_enemy_hp = enemy_hp;
	enemy_draw_hp_bar = draw_hp_bar;
}

function Enemy_SetDefense(value) { enemy_defense = value;}

function Enemy_SetDamage(damage){ damage = damage;}

function Enemy_SetSpareable(spareable){ enemy_is_spareable = spareable;}

function Enemy_SetReward(Exp, Gold) { Exp_Give = Exp; Gold_Give = Gold;}
