var board_size = 
[
[70, 70, 70, 70],
[70, 70, 130, 130],
];

function end_turn()
{
	var end_turn_menu_text =
	[
	"turn 2 text",
	"turn 3 text",
	];
	if turn > -1
	{
		if array_height_2d(end_turn_menu_text) >= (turn + 1)
			Battle_SetMenuDialog(end_turn_menu_text[turn]);
	}
	else
	{
		obj_battle_controller.menu_text_typist.reset();
		Battle_SetMenuDialog(obj_battle_controller.default_menu_text);
	}
	obj_battle_controller.battle_state = 0;
	obj_battle_controller.menu_state = 0;
	Set_BoardSize();
	Set_BoardAngle();
	Set_BoardPos();
	instance_destroy(obj_battle_bullet_parents);
	instance_destroy();
}

turn = obj_battle_controller.battle_turn - 1;

if turn = -1 end_turn();

turn_time =
[300,120];


start = 1;
time = 0;

if turn > -1
if array_height_2d(board_size) >= (turn + 1)
Set_BoardSize(board_size[turn, 0], board_size[turn, 1], board_size[turn, 2], board_size[turn, 3]);
else Set_BoardSize();

obj_enemy_parent.draw_damage = false;



