///@desc Converts the Item name into Stats of the Item
function ConvertItemNameToStat()
{
	switch global.AttackItem
	{
		case "Stick":
		global.player_attack = 10;
		global.bar_count = 1;
		break
	}
	switch global.DefenseItem
	{
		case "Bandage":
		global.player_def = 10;
		break
	}
}


///@desc Gets the base ATK and DEF of the player and then automatically sets it
function Player_GetBaseStats()
{
	global.player_base_atk = global.lv * 2 - 2;
	global.player_base_def = floor(global.lv / 5);
}


function Player_GetLVBaseExp()
{
	var base_exp = 
	[0, 10, 30, 70, 120, 200, 300, 500, 800, 1200, 1700,
	 2500, 3500, 5000, 7000, 10000, 15000, 25000, 50000, 99999];
	return base_exp[global.lv - 1];
}

function Player_GetExpNext()
{
	var _exp = 
	[10, 20, 40, 50, 80, 100, 200, 300, 400, 500,
	 800, 1000, 1500, 2000, 3000, 5000, 10000, 25000, 49999];
	return Sigma(_exp, 0, global.lv - 2);
}



