///@desc Turns, very trash, working on it
if state == 2 {
	if start time++;
	var _turn = oBattleController.battle_turn - 1;
	if _turn <= -1 {
		end_turn();
		exit;
	}
	if _turn < array_length(turn_time) {
		if time == turn_time[_turn] end_turn();
	}
	else end_turn();
	if time == 0
		if array_height_2d(board_size) >= _turn {
			Set_BoardSize(board_size[_turn, 0], board_size[_turn, 1], board_size[_turn, 2],
				board_size[_turn, 3]);
			if !AttacksLoaded event_user(1);
		}
	if array_length(turnts) > _turn {
		for (var i = 0, n = array_length(turnts[_turn]); i < n; ++i) {
			if turntsInterval[_turn, i] == 1 {
				if time == turntsDelay[_turn, i]
					time_source_start(turnts[_turn, i]);
			}
			else {
				if turntsRep[_turn, i] {
					if time == turntsDelay[_turn, i] + turntsInterval[_turn, i] * turntsRepC[_turn, i] {
						time_source_start(turnts[_turn, i]);
						turntsRepC[_turn, i]++;
						turntsRep[_turn, i]--;
					}
				}
			}
		}
	}
	else end_turn();
}
