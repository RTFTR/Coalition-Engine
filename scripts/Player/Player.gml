///@desc Converts the Item name into Stats of the Item
function ConvertItemNameToStat()
{
	switch global.AttackItem
	{
		case "Stick":
		global.player_attack = 10;
		global.bar_count = 2;
		break
	}
	switch global.DefenseItem
	{
		case "Bandage":
		global.player_def = 10;
		break
	}
}
