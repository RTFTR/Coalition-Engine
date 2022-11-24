///@desc Turn Making
// Down here you can make your turn codes using TurnCreate()
_turn = oBattleController.battle_turn - 1;
time = time;
///@desc Creates the attack of the turn
///@param {real} Turn			The Turn number to add the attack to
///@param {real} Attack			The Attack number of the turn
///@param {real} delay			The delay of the attack (This replaces "if time == xx")
///@param {function} Content	The Contents of the attack (the code you put in the blocks)
///@param {real} Repeat_Times	The times to Repeat the attack for (Replaces alarm/(time % xx))
///@param {real} Interval		The Interval bewteen the repeats (Acts as the "xx" in      ^) 
function TurnCreate(turn, attack, delay, content, repeat_times = 1, interval = 1)
{
	turntsDelay[turn, attack] = delay;
	turntsRep[turn, attack] = round(repeat_times);
	turntsRepC[turn, attack] = 0;
	turntsInterval[turn, attack] = round(interval);
	turnts[turn, attack] =
	time_source_create(time_source_game, 1, time_source_units_frames, content, []);
}
