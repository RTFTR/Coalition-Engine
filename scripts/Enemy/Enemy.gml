///@desc Loads the datas of an encounter that you have stored in this script
///@param {real} encounter_number Loads the data of the argument
function Enemy_Function_Load(encounter_number = global.battle_encounter) {
	enemy = [];
	enemy_name = [];
	enemy_hp = [];
	enemy_hp_max = [];
	enemy_draw_hp_bar = [];
	enemy_name_extra = ["", "", ""];
	
	var enemy_presets=
	[
		[noone, oEnemySansExample, noone],
		//Following are tests
		[noone, oEnemySans2, noone],
		[noone, oRhythm, noone],
		[noone, oEnemyTest, noone],
	];
	
	enemy_instance = [];
	for (var i = 0, enemies; i < 3; ++i)
	{
		enemies[i] = enemy_presets[encounter_number, i];
		enemy[i] = enemies[i];
		if enemies[i] != noone
		{
			array_push(enemy_instance, instance_create_depth(160 * (i + 1), 250, 1, enemies[i]));
			enemy_name[i] =			enemies[i].enemy_name;
			enemy_hp[i] =			enemies[i].enemy_hp;
			enemy_hp_max[i] =		enemies[i].enemy_hp_max;
			enemy_draw_hp_bar[i] =	enemies[i].enemy_draw_hp_bar;
			for(var ii = 0, kk = array_length(enemies[i].enemy_act); ii < kk; ++ii)
			{
				enemy_act[i, ii] =			enemies[i].enemy_act[ii];
				enemy_act_text[i, ii] =		enemies[i].enemy_act_text[ii];
				enemy_act_function[i, ii] = enemies[i].enemy_act_function[ii];
			}
			global.BossFight = enemies[i].is_boss;
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
	Enemy_NameUpdate();
}

///@desc Sets the name of the enemy
///@param {string} name The name of the enemy
function Enemy_SetName(name)
{
	enemy_name = name;
}

//@desc UNUSED
function Enemy_NameUpdate() {
	////Check which slot doesn't have enemy
	//with oBattleController {
	//	for(var i = 0; i < 3; ++i)
	//		enemy_name_extra[i] = "";
	//	var temp_enemy = [],
	//		Txt = [" A", " B", " C"]
	//	for (var i = 0; i < 3; ++i) { //Selects the enemy obj to check
	//		if instance_number(enemy[i]) > 1
	//		{
	//			//Stores the enemy
	//			for(var ii = 0; ii < 3; ++ii) temp_enemy[i] = instance_find(enemy[i], ii);
	//			//Adds the text
	//			for(var n = 0, k = array_length(temp_enemy), j = 0; n < k; ++n) {
	//					if enemy[n] = noone j++;
	//						enemy_name_extra[j] = Txt[n];
	//					j++;
	//			}
	//		}
	//	}
	//}
}

///@desc Sets the ACT texts of the enemy
///@param {Array} name		The names of the ACT options
///@param {Array} text		The texts that appears when the ACT options are selected
///@param {Array} function	The event to happen when the ACT options are selected (Default none)
function Enemy_SetActTexts(name, text, functions = array_create(array_length(name), function() {}))
{
	var i = 0, n = array_length(name);
	repeat n
	{
		enemy_act[i] = name[i];
		enemy_act_text[i] = text[i];
		enemy_act_function[i] = functions[i];
		++i;
	}
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
///@param {real}  value			The defense value
function Enemy_SetDefense(value)
{
	enemy_defense = value;
}

///@desc Sets the Damage of the enemy
///@param {real}  value			The attack value
function Enemy_SetDamage(damage)
{
	self.damage = damage;
}

///@desc Sets whether the enemy can be spared
///@param {bool}  spareable		Can the enemy be spared
function Enemy_SetSpareable(spareable)
{
	enemy_is_spareable = spareable;
}

///@desc Sets the Damage of the enemy
///@param {real}  Exp			Rewarded EXP points
///@param {real}  Gold			Rewarded Gold
function Enemy_SetReward(Exp, Gold)
{
	Exp_Give = Exp;
	Gold_Give = Gold;
}

