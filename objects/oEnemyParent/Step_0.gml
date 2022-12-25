///@desc Turns, very trash, working on it
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
