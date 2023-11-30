///@desc Drawing
var input_horizontal = CHECK_HORIZONTAL,
	input_vertical =   CHECK_VERTICAL,
	//input_confirm =    input_check("confirm"),
	input_cancel =     input_check("cancel"),
	input_menu =	   input_check_pressed("menu"),
	spd = (global.spd + input_cancel) * speed_multiplier,
	scale_x = last_dir,
	assign_sprite = last_sprite;


#region //Check if a Overworld Dialog is happening (Currently unsued)
//if !dialog()
//	if input_menu
//	{
//		Move_Noise();
//		draw_menu = !draw_menu; menu_choice[0] = 0;
//		soul_target[1] = (y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * oGlobal.MainCamera.Scale[1];
//		menu_state = 0;
//	}

//if !moveable spd = 0;
#endregion

//Sets a black mask on player, similar to the Last Corridor
if room == room_overworld shader_set(shdBlackMask);
draw_self();
if room == room_overworld shader_reset();
show_hitbox(c_purple);

last_sprite = assign_sprite;
last_dir = scale_x;

//Encounter animation
if encounter_state == 1
	draw_sprite(sprEncounterExclaimation, 0, x, y - sprite_height);