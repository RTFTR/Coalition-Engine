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
//		soul_target[1] = (y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * oGlobal.camera_scale_y;
//		menu_state = 0;
//	}

//if !moveable spd = 0;
#endregion

#region Movement spriting (Old)
//if input_horizontal != 0
//{
//	assign_sprite = dir_sprite[2];
//	scale_x = -sign(input_horizontal);
	
//	x += input_horizontal * spd;
//}
//if input_vertical != 0
//{
//	scale_x = 1;
//	if input_vertical == 1 assign_sprite = dir_sprite[1];
//	if input_vertical == -1 assign_sprite = dir_sprite[0];
//	y += input_vertical * spd
//}

////Checking collision with Overworld objects
//with oOWCollision
//	if !Is_Background		//Check if the instance is the background or not
//	{						//If not then prevent player from entering
//		if place_meeting(x, y, other)
//		{
//			with other
//			{
//				x = xprevious;
//				y = yprevious;
//			}
//			collide = true
//		}
//	}
//	else					//If it's the background then prevent player from exiting
//	{
//		with other
//		{
//			x = clamp(x, sprite_width / 2, other.sprite_width + sprite_width / 2);
//			y = clamp(y, sprite_height, other.sprite_height);
//		}
//	}
#endregion

if room == room_overworld
	shader_set(shdBlackMask);
draw_self();
if room == room_overworld
	shader_reset();
show_hitbox(c_purple);

last_sprite = assign_sprite;
last_dir = scale_x;

//Encounter animation
if encounter_state == 1
	draw_sprite(sprEncounterExclaimation, 0, x, y - sprite_height);