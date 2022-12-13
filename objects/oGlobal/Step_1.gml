/// @description Global

var ver = string(GM_runtime_version),
	InputTicking = false;
if string_copy(ver, 1, 4) != "2022" InputTicking = true
else if real(string_copy(ver, 6, 1)) < 5 InputTicking = true;
if InputTicking input_tick(); // Input handler, do not delete!

if keyboard_check(vk_escape)
{
	quit_timer++
	if quit_timer >= 60 game_end();
}
else
{
	quit_timer = quit_timer ? quit_timer-- : 0;
}

global.timer++;

if keyboard_check_pressed(vk_f2) {instance_destroy(oBulletParents); game_restart();}
if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()) alarm[1] = 1}//Fullscreen
if keyboard_check_pressed(vk_f9) global.show_hitbox = !global.show_hitbox;
if keyboard_check_pressed(vk_f3)
{
	global.debug = !global.debug;
	if instance_exists(oOWPlayer)
		with oOWPlayer
			debug = !debug;
}
if keyboard_check(vk_alt) if keyboard_check_pressed(ord("S")) Screenshot(room_get_name(room));