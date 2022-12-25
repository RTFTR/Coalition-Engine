if !is_setting{
	if input_check_pressed("confirm") room_goto(room_overworld);
	//if input_check_pressed("confirm") room_goto(room_battle);
	if keyboard_check_pressed(ord("R"))
	{
		global.battle_encounter = 2;
		room_goto(room_battle);
	}
	//if keyboard_check_pressed(vk_space) {global.battle_encounter = 1; room_goto(room_battle);}
	if keyboard_check_pressed(vk_space)
	{
		global.battle_encounter = (global.easy ? 1 : 3);
		room_goto(room_battle);
	}
}

//global.battle_encounter = 3; room_goto(room_battle);
if input_check_pressed("menu") is_setting = !is_setting;

window_set_fullscreen(false);