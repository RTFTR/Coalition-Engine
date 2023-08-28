///@desc Turns, very trash, working on it
function end_turn()
{
	//Reset menu text
	var turn = oBattleController.battle_turn - 1;
	if array_length(end_turn_menu_text) >= (turn + 1) and turn > -1
		Battle_SetMenuDialog(end_turn_menu_text[turn]);
	else {
		with oBattleController
		{
			menu_text_typist.reset();
			__text_writer.page(0);
			Battle_SetMenuDialog(default_menu_text);
		}
	}
	with oBattleController
	{
		//Reset menu state
		battle_state = 0;
		menu_state = 0;
		//Effect removal
		if Effect.SeaTea
		{
			Effect.SeaTeaTurns--;
			if !Effect.SeaTeaTurns
			{
				Effect.SeaTeaTurns = 4;
				Effect.SeaTea = false;
				global.spd /= 2;
			}
		}
	}
	//Armor healing
	if (turn % 2) == 1
	{
		if global.data.DefenseItem == "Temmie Armor" or
			global.data.DefenseItem == "Stained Apron"
		{
			global.hp++;
			audio_play(snd_item_heal);
		}
	}
	//Reset box
	Set_BoardSize();
	oBoard.image_angle %= 360;
	Set_BoardAngle();
	Set_BoardPos();
	//Reset soul
	with oSoul
		draw_angle = (mode == SOUL_MODE.YELLOW ? 180 : 0);
	//Clear bones
	with oBulletBone
		if retract_on_end
		{
			at_turn_end = true;
			destroy_on_turn_end = false;
			can_hurt = 0;
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 25, "length", length, 10);
			alarm[1] = 25;
		}
	with oBulletParents
		if destroy_on_turn_end instance_destroy();
	state = 0;
	draw_damage = false;
	time = -1;
	Enemy_NameUpdate();
	//Code to prevent crash
	array_push(dialog_text, "");
	dialog_init(dialog_text[turn + 1]);
	//Code to prevent crash
	array_push(dialog_text, "");
	TurnData.IsHeal = false;
	//Debugging
	TurnData.AttacksLoaded = false;
	event_user(1);
	if TurnData.TempTurn != -1
		oBattleController.battle_turn = TurnData.TempTurn + 1;
	TurnData.TempTurn = -1;
	TurnData.LoopChecked = false;
}

if state == 2 and !__died and enemy_in_battle {
	//Timer
	if start time++;
	var _turn = oBattleController.battle_turn - 1;
	if !TurnData.LoopChecked && TurnData.AttackLoopCondition()
	{
		TurnData.LoopChecked = true;
		TurnData.TempTurn = _turn;
		oBattleController.battle_turn = array_choose(TurnData.AttackLoopTurn) + 1;
		_turn = oBattleController.battle_turn - 1;
	}
	if _turn <= -1 {
		end_turn();
		exit;
	}
	//If the attack is not a healing attack
	if !TurnData.IsHeal
	{
		//If the turn is not valid, end turn
		if _turn < array_length(turn_time)
		{
			//If it's valid, and the timer reaches the limit, turn ends
			if time == turn_time[_turn] end_turn();
		}
		else end_turn();
		//Initalizing turn
		if time == 0
			if array_height_2d(board_size) >= _turn
			{
				//Sets the board size to the value that has been set in Create event
				Set_BoardSize(board_size[_turn, 0], board_size[_turn, 1], board_size[_turn, 2],
					board_size[_turn, 3]);
				//Load the attacks if they aren't loaded yet
				if !TurnData.AttacksLoaded event_user(1);
			}
		//If the turn is valid
		if array_length(TurnData.Functions) > _turn
		{
			var i = 0;
			//Check through all stored attack (functions)
			repeat(array_length(TurnData.Functions[_turn]))
			{
				//If the attack doesn't repeat
				if TurnData.AttackInterval[_turn, i] == 1
				{
					//If the timer reaches the assigned time for the attack to appear, launch attack
					if time == TurnData.AttackDelay[_turn, i]
						TurnData.Functions[_turn, i]();
				}
				else
				{
					//If the attack repeats
					if TurnData.AttackRepeat[_turn, i]
					{
						//If timer reaches the assigned time and the assigned interval within the
						//assigned repeat count
						if time == TurnData.AttackDelay[_turn, i] + 
									TurnData.AttackInterval[_turn, i] * TurnData.AttackRepeatCount[_turn, i]
						{
							//Launch the attack, add 1 to the repeated counter, minus 1 to the
							//repeats left counter
							TurnData.Functions[_turn, i]();
							TurnData.AttackRepeatCount[_turn, i]++;
							TurnData.AttackRepeat[_turn, i]--;
						}
					}
				}
				i++;
			}
		}
		else end_turn();
	}
	else
	{
		//If the attack is a healing attack, launch the attack (timer and attacks are stored in the function)
		if TurnData.HealAttacks[TurnData.HealNum] != -1
			TurnData.HealAttacks[TurnData.HealNum]();
		//If timer reaches the limit, turn ends
		if time == TurnData.HealTime[TurnData.HealNum]
			end_turn();
	}
}

if ContainsDust
{
	if !surface_exists(__dust_surface) __dust_surface = surface_create(640, 480);
		if !__died and __is_dying and __death_time >= 1 + attack_end_time {
			//Dust height adding
			if dust_height < enemy_total_height {
				dust_height += enemy_total_height / dust_speed * 6;
			}
			for (var i = 0; i < dust_height * dust_amount / enemy_total_height; i += 3) {
				if dust_alpha[i] > 0 {
					dust_pos[i, 0] += dust_displace[i, 0];
					dust_pos[i, 1] += dust_displace[i, 1];
					dust_alpha[i] -= 1 / dust_life[i];
					if !__dust_being_drawn __dust_being_drawn = true;
				}
			}
		}
}

//Calculates the height and width of the enemy, then initalizes the dust particles (Will only run once, don't worry for lag)
if enemy_total_height == 0 or enemy_max_width == 0
{
	var i = 0;
	repeat(array_length(enemy_sprites))
	{
		enemy_total_height += sprite_get_height(enemy_sprites[i]) * enemy_sprite_scale[i, 1];
		enemy_max_width = max(sprite_get_width(enemy_sprites[i]) * enemy_sprite_scale[i, 0],
								enemy_max_width);
		++i;
	}

	//Particles aren't used because if a lot of particles are created then the CPU will be abused
	//And the dust amount is on average at least a couple hundred, so drawing in arrays are better
	if ContainsDust {
		dust_height = 0;
		dust_amount = enemy_total_height * enemy_max_width / 6;
		//Using array create functions to speed up loading time because it's easy to have over 2000 values in the arrays
		var _f = function()
		{
			var dust_speed = random_range(1, 3),
				dust_direction = random_range(55, 125);
			return [dust_speed * dcos(dust_direction),
					dust_speed * -dsin(dust_direction)];
		}
		dust_displace = array_create_ext(dust_amount, _f);
		_f = function()
		{
			return irandom_range(60, 120);
		}
		dust_life = array_create_ext(dust_amount, _f);
		dust_alpha = array_create(dust_amount, 1);
		_f = function()
		{
			return random(360);
		}
		dust_angle = array_create_ext(dust_amount, _f);
		_f = function()
		{
			return random_range(1, -1);
		}
		dust_rotate = array_create_ext(dust_amount, _f);
		i = 0;
		repeat(dust_amount)
		{
			dust_pos[i] = [random_range(-enemy_max_width, enemy_max_width) / 2 + x,
						   y - enemy_total_height + (i * 6 / enemy_max_width)];
			i++;
		}
	}
}