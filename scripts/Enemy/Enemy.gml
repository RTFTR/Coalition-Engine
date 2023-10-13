function Enemy_SetEncoutner(encounter = array_length(global.enemy_presets), left = noone, middle = noone, right = noone) {
	global.enemy_presets[encounter] = [left, middle, right];
}

///@desc Loads the datas of an encounter that you have stored in this script
///@param {real} encounter_number Loads the data of the argument
function Enemy_Function_Load(encounter_number = global.battle_encounter) {
	enemy = [];
	enemy_name = [];
	enemy_hp = [];
	enemy_hp_max = [];
	enemy_draw_hp_bar = [];
	enemy_name_extra = ["", "", ""];
	
	var enemy_presets= global.enemy_presets;
	
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

function Enemy_NameUpdate() {}


function Enemy() constructor
{
	/**
		Sets the name of the enemy
		@param {Asset.GMObject}	enemy	The enemy to set the name of
		@param {string}	text			The name to set to
	*/
	static SetName = function(enemy, text)
	{
		enemy.enemy_name = text;
	}
	/**
		Sets the act data of the enemy
		@param {Asset.GMObject} enemy	The enemy to set the act data to
		@param {real} act_number		The number of the act (First act, i.e. Check, is 0, the second is 1, and so on)
		@param {string} name			The name of the act
		@param {string} text			The text to display if selected
		@param {function} function		The function to execute if selected (Optional)
	*/
	static SetAct = function(enemy, act, name, text, func = -1)
	{
		with enemy
		{
			enemy_act[act] = name;
			enemy_act_text[act] = text;
			if func != -1 enemy_act_function[act] = func;
		}
	}
	/**
		Sets the HP data of the enemy
		@param {Asset.GMObject} enemy	The enemy to set the HP data to
		@param {rael} max_hp			The max hp of the enemy
		@param {real} current_hp		The current hp of the enemy (Default max)
		@param {bool} draw_hp_bar		Whether the hp bar will be drawn in the menu
	*/
	static SetHPStats = function(enemy, max_hp, current_hp = max_hp, draw_hp_bar = true)
	{
		with enemy
		{
			enemy_hp_max = max_hp;
			enemy_hp = current_hp;
			_enemy_hp = enemy_hp;
			enemy_draw_hp_bar = draw_hp_bar;
		}
	}
	/**
		Sets the Defense of the enemy
		@param {Asset.GMObject} enemy	The enemy to set the defense to
		@param {real}  value			The defense value
	*/
	static SetDefense = function(enemy, value)
	{
		enemy.enemy_defense = value;
	}
	/**
		Sets the Damage of the enemy (Taken by enemy, not inflicted to player)
		@param {Asset.GMObject} enemy	The enemy to set the damage to
		@param {real} damage			The attack value
	*/
	static SetDamage = function(enemy, damage)
	{
		enemy.damage = damage;
	}
	/**
		Sets whether the enemy can be spared
		@param {Asset.GMObject} enemy	The enemy to set whether it is sparable
		@param {bool}  spareable		Can the enemy be spared
	*/
	static SetSpareable = function(enemy, spareable)
	{
		enemy.enemy_is_spareable = spareable;
	}
	/**
		Sets the Reward of the enemy
		@param {Asset.GMObject} enemy	The enemy to set the rewards to
		@param {real}  Exp				Rewarded EXP points
		@param {real}  Gold				Rewarded Gold
	*/
	static SetReward = function(enemy, Exp, Gold)
	{
		with enemy
		{
			Exp_Give = Exp;
			Gold_Give = Gold;
		}
	}
}