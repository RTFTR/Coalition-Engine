/// @description Global Loop
var input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
	input_vertical = input_check_pressed("down") - input_check_pressed("up"),
	input_confirm = input_check_pressed("confirm"),
	input_cancel = input_check_pressed("cancel");
	
if keyboard_check(vk_escape)
{
	quit_timer++;
	if quit_timer >= 60 game_end();
}
else
{
	quit_timer = quit_timer ? quit_timer - 2 : 0;
}

global.timer++;

if keyboard_check_pressed(vk_f2)
{
	audio_stop_all();
	instance_destroy(obj_ParentBullet);
	//room_goto(rRestart);
	game_restart();
}

if keyboard_check_pressed(vk_f4)
{
	window_set_fullscreen(!window_get_fullscreen());
	alarm[0] = 1;
}

if keyboard_check_pressed(vk_f9)
	global.show_hitbox = !global.show_hitbox;
	
if keyboard_check_pressed(vk_f3)
	global.debug = !global.debug;

if global.debug 
{
	if keyboard_check(vk_rshift) 
	{
		if room_speed > 5 
			room_speed += 5 * input_horizontal;

	if keyboard_check(ord("R")) room_speed = 60;
	if keyboard_check(ord("F")) room_speed = 600;
	}
	with obj_BattleController
	{
		if battle_state == 0 and keyboard_check(vk_control) 
		{
			battle_turn += input_horizontal;
			battle_turn = max(0, battle_turn);
		}
		if global.hp <= 1 
		{
			global.hp = global.hp_max;
			audio_play(snd_item_heal);
		}
	}
}

if keyboard_check(vk_alt)
	if keyboard_check_pressed(ord("S"))
		Screenshot(room_get_name(room));

//if room == rRestart
//{
//	restart_timer++;
//	if restart_timer == restart_ender game_restart();
//}
