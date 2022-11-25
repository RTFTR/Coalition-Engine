///@desc Loads the datas of an encounter that you have stored in this script
///@param {real} encounter_number Loads the data of the argument
function Enemy_Function_Load(encounter_number) {
	enemy = [];
	enemy_name = [];
	enemy_hp = [];
	enemy_hp_max = [];
	enemy_draw_hp_bar = [];
	
	var enemy_presets=
	[
		[noone, oEnemySans, noone],
		[noone, oEnemySans2, noone],
		[noone, oRhythm, noone],
	];
	var enemies
	
	for (var i = 0; i < 3; ++i)
	{
		enemies[i] = enemy_presets[encounter_number, i];
		enemy[i] = enemies[i];
		if enemies[i] != noone
		{
			instance_create_depth(160 * (i + 1), 250, 1, enemies[i]);
			enemy_name[i] =			enemies[i].enemy_name;
			enemy_hp[i] =			enemies[i].enemy_hp;
			enemy_hp_max[i] =		enemies[i].enemy_hp_max;
			enemy_draw_hp_bar[i] =	enemies[i].enemy_draw_hp_bar;
			for(var ii = 0; ii < 6; ++ii)
			{
				enemy_act[i, ii] =		enemies[i].enemy_act[ii];
				enemy_act_text[i, ii] = enemies[i].enemy_act_text[ii];
			}
			if enemies[i].is_boss = true global.BossFight = true;
			if enemies[i].begin_at_turn {
				menu_state = -1;
				battle_turn++;
				begin_at_turn = true;
				dialog_start();
				oSoul.visible = true;
			}
		}
		else
		{
			enemy_act[i] = [""];
		}
	}
}

///@desc Sets the name of the enemy
///@param {string} name The name of the enemy
function Enemy_SetName(name)
{
	enemy_name = name;
}

///@desc Sets the ACT texts of the enemy
///@param {string} name		The name of the ACT option
///@param {string} text		The text that appears when the ACT option is selected
function Enemy_SetActTexts(name, text)
{
	enemy_act = name;
	enemy_act_text = text;
}

///@desc Sets the (Max) HP and the visibility of the hp bar of the enemy
///@param {real} max_hp		Sets the Max HP of the enemy
///@param {real} current_hp	Sets the Current HP of the enemy (i.e. the enemy has only 40 of 90 hp in the beginning)
///@param {bool} draw_hp_bar	Sets whether the HP bar is visible during the attack
function Enemy_SetHPStats(max_hp, current_hp = max_hp, draw_hp_bar = true)
{
	enemy_hp_max = max_hp;
	enemy_hp = current_hp;
	_enemy_hp = enemy_hp;
	enemy_draw_hp_bar = draw_hp_bar;
}

///@desc Sets the Defense of the enemy
///@param {id.instance} target	The enemy to set the stats for
///@param {real}  value			The defense value
function Enemy_SetDefense(target, value) { target.enemy_defense = value;}

///@desc Sets the Damage of the enemy
///@param {id.instance} target	The enemy to set the stats for
///@param {real}  value			The attack value
function Enemy_SetDamage(target, damage){ target.damage = damage;}

///@desc Sets the Damage of the enemy
///@param {id.instance} target	The enemy to set the stats for
///@param {bool}  spareable		Can the enemy be spared
function Enemy_SetSpareable(target, spareable){ target.enemy_is_spareable = spareable;}

///@desc Sets the Damage of the enemy
///@param {id.instance} target	The enemy to set the stats for
///@param {real}  Exp			Rewarded EXP points
///@param {real}  Gold			Rewarded Gold
function Enemy_SetReward(target, Exp, Gold) { with target { Exp_Give = Exp; Gold_Give = Gold;}}
