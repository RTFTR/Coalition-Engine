event_inherited();
enemy_name = "Sans";
enemy_act = ["Check", "sans 1", "sans2", "sans3", "sans4", "sans5"];
enemy_act_text = ["funny skeleton man[delay,1000] 1 ATK 1 DEF", "sans 1 text", "sans2twxt", "sans3text", "sans4text", "sans5tex"];
Enemy_SetHPStats(100, 50, 0);
is_dodge = 1;

Battle_SetTurnTime(
[
600,
300,
600,
300,
700,
900,
infinity,
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
	[42, 42, 42, 42],
]);

Battle_EnemyDialog(0, [
	"intro text",
	"turn 1 text",
	"turn 2 text",
	"turn 3 text",
	"turn 4 text",
	"turn 5 text",
	"turn 6 text",
]);