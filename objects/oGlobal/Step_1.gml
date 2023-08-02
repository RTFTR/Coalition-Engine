/// @description Global

//input_tick(); // Input handler, do not delete! (Unless you are 2022.5+)

if keyboard_check(vk_escape)
{
	quit_timer++;
	if quit_timer >= 60 game_end();
}
else
{
	quit_timer = quit_timer > 0 ? quit_timer - 2 : 0;
}

global.timer++;

if keyboard_check_pressed(vk_f2)
{
	audio_stop_all();
	instance_destroy(oBulletParents);
	//room_goto(rRestart);
	game_restart();
}
if keyboard_check_pressed(vk_f4)
{
	window_set_fullscreen(!window_get_fullscreen());
	alarm[0] = 1;
}
//Debug functions
if ALLOW_DEBUG
{
	global.debug ^= keyboard_check_released(vk_f3);
	global.show_hitbox ^= keyboard_check_released(vk_f9);
	if keyboard_check_pressed(vk_f7)
		room_goto(rDebug);
	if keyboard_check(vk_alt)
		if keyboard_check_pressed(ord("S"))
			Screenshot(room_get_name(room));
}

if room == rRestart
{
	restart_timer++;
	if restart_timer == restart_ender game_restart();
}

//Effect surfaces
if !surface_exists(GradientSurf) GradientSurf = surface_create(640, 480);

if RGBShake > 0
{
	RGBShake -= RGBDecrease;
	if !surface_exists(RGBSurf) RGBSurf = surface_create(640, 480);
}
else if surface_exists(RGBSurf) surface_free(RGBSurf);