/// @description Global

input_tick(); // Input handler, do not delete!

if keyboard_check(vk_escape)
{
	quit_timer++
	if quit_timer >= 60 game_end();
}
else
{
	if quit_timer quit_timer--;
	else quit_timer = 0;
}

global.timer++;

if keyboard_check_pressed(vk_f2) game_restart();
if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()) alarm[1] = 1}//Fullscreen

