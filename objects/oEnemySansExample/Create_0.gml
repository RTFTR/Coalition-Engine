event_inherited();
enemy_name = "Sans";
enemy_act = ["Check", "sans 1", "sans2", "sans3", "sans4", "sans5"];
enemy_act_text = ["funny skeleton man[delay,1000] 1 ATK 1 DEF", "sans 1 text", "sans2twxt", "sans3text", "sans4text", "sans5tex"];
Enemy_SetHPStats(100, 100, 0);
is_dodge = 0;

Battle_SetTurnTime(
[
	600,
	300,
	600,
	300,
	700,
	900,
	600,
	600,
	900,
	600,
	600,
	600,
]
);

Battle_SetTurnBoardSize(
[
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[70, 70, 70, 70],
	[42, 42, 42, 42],
]);

var text;
for(var i = 0; i < 12; i++)
{
	text = LoadTextFromFile("SansTest2.txt", 1, "@" + string(i));
	Battle_EnemyDialog(i, text);
}
