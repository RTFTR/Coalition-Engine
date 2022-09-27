if keyboard_check_pressed(vk_space) Encounter_Begin();
var input_horizontal = input_check("right") - input_check("left");
var input_vertical =   input_check("down") - input_check("up");
var input_confirm =    input_check("confirm");
var input_cancel =     input_check("cancel");
var input_menu =	   input_check_pressed("menu");
var spd = 2 + input_cancel;
var scale_x = last_dir;
var assign_sprite = last_sprite;


if !Is_Dialog()
	if input_menu
	{
		Move_Noise();
		draw_menu = !draw_menu; menu_choice[0] = 0;
		soul_target[1] = (y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * global.camera_scale_y;
		menu_state = 0;
	}

if !char_moveable spd = 0;

if input_horizontal != 0
{
	assign_sprite = dir_sprite[2];
	scale_x = -sign(input_horizontal);
	
	x += input_horizontal * spd;
}
if input_vertical != 0
{
	scale_x = 1;
	if input_vertical == 1 assign_sprite = dir_sprite[1];
	if input_vertical == -1 assign_sprite = dir_sprite[0];
	y += input_vertical * spd
}

with(obj_ow_collision)
	if place_meeting(x, y, other)
	{
		with(other)
		{
			x = xprevious;
			y = yprevious;
		}
		collide = true
	}


if !char_moveable {assign_sprite = last_sprite; scale_x = last_dir;}

image_xscale = scale_x;
if assign_sprite != -1 sprite_index = assign_sprite;
if (input_horizontal != 0 or input_vertical != 0) and char_moveable image_index += 0.2;
else image_index = 0;


draw_self();
show_hitbox(c_purple)

last_sprite = assign_sprite;
last_dir = scale_x;

if encounter_state
{
	char_moveable = false;
	draw_menu = false
	encounter_time++;
	if encounter_state == 1
	{
		draw_sprite(spr_encounter_exclaim, 0, x, y - sprite_height);
		if encounter_time == 30 {encounter_state++; encounter_time = 0;}
	}
	if encounter_state == 2
	{
		encounter_draw[0] = 1;
		if !(encounter_time % 5) and encounter_time < 15
		{
			sfx_play(snd_noise);
			encounter_draw[2] = !encounter_draw[2];
		}
		if encounter_time == 15
		{
			encounter_draw[1] = 0;
			encounter_draw[2] = 1;
			sfx_play(snd_encounter_soul_move);
			TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 30, "encounter_soul_x", encounter_soul_x, 48);
			TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 30, "encounter_soul_y", encounter_soul_y, 454);
		}
		if encounter_time == 45 {encounter_state++; encounter_time = 0;}
	}
	if encounter_state == 3
	{
		if encounter_time == 1
		{
			Fader_Fade(1, 0 , 20, 0, c_black);
			room_goto(room_battle);
		}
	}
}