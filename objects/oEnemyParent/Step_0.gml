///@desc Turns, very trash, working on it
function end_turn()
{
	var turn = oBattleController.battle_turn - 1;
	if array_length(end_turn_menu_text) >= (turn + 1) and turn > -1
		Battle_SetMenuDialog(end_turn_menu_text[turn]);
	else {
		with oBattleController
		{
			menu_text_typist.reset();
			text_writer.page(0);
			Battle_SetMenuDialog(default_menu_text);
		}
	}
	with oBattleController
	{
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
	Set_BoardSize();
	oBoard.image_angle %= 360;
	Set_BoardAngle();
	Set_BoardPos();
	with oSoul
		draw_angle = (mode == SOUL_MODE.YELLOW ? 180 : 0);
	with oBulletBone
		if retract_on_end
		{
			at_turn_end = true;
			destroy_on_turn_end = false;
			can_hurt = 0;
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 25, "length", length, 14);
			var _handle = call_later(25, time_source_units_frames, function() { instance_destroy()});
		}
	with oBulletParents
		if destroy_on_turn_end instance_destroy();
	state = 0;
	draw_damage = false;
	time = -1;
	if array_length(TurnData.TimeSources) > turn and turn > 0
		for (var i = 0, n = array_length(TurnData.TimeSources[turn]); i < n; ++i)
			time_source_destroy(TurnData.TimeSources[turn, i]);
	Enemy_NameUpdate();
	dialog_init(dialog_text[turn + 1]);
	//Code to prevent crash
	array_push(dialog_text, "");
	TurnData.IsHeal = false;
}


function RemoveEnemy()
{
	if instance_exists(oBattleController)
		with oBattleController {
			var enemy_slot = other.x / 160 - 1;
			enemy[enemy_slot] = noone;
			enemy_draw_hp_bar[enemy_slot] = 0;
		}
}

if state == 2 {
	if start time++;
	var _turn = oBattleController.battle_turn - 1;
	if _turn <= -1 {
		end_turn();
		exit;
	}
	if !TurnData.IsHeal
	{
		if _turn < array_length(turn_time)
		{
			if time == turn_time[_turn] end_turn();
		}
		else end_turn();
		if time == 0
			if array_height_2d(board_size) >= _turn
			{
				Set_BoardSize(board_size[_turn, 0], board_size[_turn, 1], board_size[_turn, 2],
					board_size[_turn, 3]);
				if !TurnData.AttacksLoaded event_user(1);
			}
		if array_length(TurnData.TimeSources) > _turn
		{
			for (var i = 0, n = array_length(TurnData.TimeSources[_turn]); i < n; ++i)
			{
				if TurnData.TSInterval[_turn, i] == 1
				{
					if time == TurnData.TSDelay[_turn, i]
						time_source_start(TurnData.TimeSources[_turn, i]);
				}
				else
				{
					if TurnData.TSRep[_turn, i]
					{
						if time == TurnData.TSDelay[_turn, i] + 
									TurnData.TSInterval[_turn, i] * TurnData.TSRepC[_turn, i]
						{
							time_source_start(TurnData.TimeSources[_turn, i]);
							TurnData.TSRepC[_turn, i]++;
							TurnData.TSRep[_turn, i]--;
						}
					}
				}
			}
		}
		else end_turn();
	}
	else
	{
		if TurnData.HealAttacks[TurnData.HealNum] != -1
			TurnData.HealAttacks[TurnData.HealNum]();
		if time == TurnData.HealTime[TurnData.HealNum]
			end_turn();
	}
}
