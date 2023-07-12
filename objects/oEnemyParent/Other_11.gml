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
	TurnData.AttackDelay[turn, attack] = delay;
	TurnData.AttackRepeat[turn, attack] = round(repeat_times);
	TurnData.AttackRepeatCount[turn, attack] = 0;
	TurnData.AttackInterval[turn, attack] = round(interval);
	TurnData.Functions[turn, attack] = content;
}
TurnData.AttacksLoaded = true;