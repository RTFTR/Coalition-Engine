///@desc Drawing
if keyboard_check_pressed(vk_space) or (x >= 830 and encounter_state == 0) Encounter_Begin();
var input_horizontal = input_check("right") - input_check("left"),
	input_vertical =   input_check("down") - input_check("up"),
	input_confirm =    input_check("confirm"),
	input_cancel =     input_check("cancel"),
	input_menu =	   input_check_pressed("menu"),
	spd = (global.spd + input_cancel) * speed_multiplier,
	scale_x = last_dir,
	assign_sprite = last_sprite;

//Check if a Overworld Dialog is happening
if !Is_Dialog()
	if input_menu
	{
		Move_Noise();
		draw_menu = !draw_menu; menu_choice[0] = 0;
		soul_target[1] = (y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * oGlobal.camera_scale_y;
		menu_state = 0;
	}

if !char_moveable spd = 0;

//Movement spriting (Old)
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

// Check collision with tiles
var lay_id = [layer_get_id("TileCollision"), layer_get_id("TileCollisionDialog")],
	map_id, colliding = [false, false];
for(var i = 0, n = array_length(lay_id); i < n; ++i)
{
	//Collision checking
	map_id[i] = layer_tilemap_get_id(lay_id[i]);
	if input_horizontal != 0
	{
		var Left =  [true, true],
			Right = [true, true];
		if input_check("left")
			Left =  [tilemap_get_at_pixel(map_id[i], bbox_left - spd, bbox_top),
					tilemap_get_at_pixel(map_id[i], bbox_left - spd, bbox_bottom)];
		else if input_check("right")
			Right = [tilemap_get_at_pixel(map_id[i], bbox_right + spd, bbox_top),
					 tilemap_get_at_pixel(map_id[i], bbox_right + spd, bbox_bottom)];
	
		Left =  !(Left[0] and Left[1]);
		Right = !(Right[0] and Right[1]);
		if Right or Left
		{
			colliding[0] = true;
		}	 
	}
	if input_vertical != 0
	{
		var Up =   [true, true],
			Down = [true, true];
		if input_check("up")
			Up =  [tilemap_get_at_pixel(map_id[i], bbox_left, bbox_top - spd),
					tilemap_get_at_pixel(map_id[i], bbox_right, bbox_top - spd)];
		else if input_check("down")
			Down = [tilemap_get_at_pixel(map_id[i], bbox_left, bbox_bottom + spd),
					 tilemap_get_at_pixel(map_id[i], bbox_right, bbox_bottom + spd)];
	
		Up =   !(Up[0] and Up[1]);
		Down = !(Down[0] and Down[1]);
		if Down or Up
		{
			colliding[1] = true;
		}	 
	}
	//Switch statement for tile type
	switch i
	{
		case 0:
		if colliding[0]
		{
			assign_sprite = dir_sprite[2];
			scale_x = -sign(input_horizontal);
	
			x += Right ? spd : -spd;
		}
		if colliding[1]
		{
			assign_sprite = dir_sprite[max(0, sign(input_vertical))];
			scale_x = 1
	
			y += Down ? spd : -spd;
		}
		break
		if colliding[0] and colliding[1]
		show_message("dialog");
	}
}

	
if !char_moveable
{
	assign_sprite = last_sprite;
	scale_x = last_dir;
}

image_xscale = scale_x;
if assign_sprite != -1 sprite_index = assign_sprite;
if (input_horizontal != 0 or input_vertical != 0) and char_moveable image_speed = spd/12;
else 
{
	image_speed = 0;
	image_index = 0.5;
}

//Menu Idle spriting thing
if draw_menu
{
	switch menu_state
	{
		case 0:		//Selection
			sprite_index = char_frisk_think;
			image_index = global.timer / 25;
		break
		case 1:		//Items
			sprite_index = char_frisk_pocket;
			image_index = global.timer / 50;
		break
		case 3:		//Cell
			sprite_index = char_frisk_cell;
		break
	}
}
else sprite_index = (assign_sprite == -1 ? dir_sprite[2] : assign_sprite)


draw_self();
show_hitbox(c_purple)

last_sprite = assign_sprite;
last_dir = scale_x;

//Encounter animation
if encounter_state
{
	char_moveable = false;
	draw_menu = false
	encounter_time++;
	if encounter_state == 1
	{
		draw_sprite(spr_encounter_exclaim, 0, x, y - sprite_height);
		if encounter_time == 30
		{
			encounter_state++;
			encounter_time = 0;
		}
	}
	if encounter_state == 2
	{
		encounter_draw[0] = 1;
		if !(encounter_time % 5) and encounter_time < 15
		{
			audio_play(snd_noise);
			encounter_draw[2] = !encounter_draw[2];
		}
		if encounter_time == 15
		{
			encounter_draw[1] = 0;
			encounter_draw[2] = 1;
			audio_play(snd_encounter_soul_move);
			TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 30, "encounter_soul_x", encounter_soul_x, 48);
			TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 30, "encounter_soul_y", encounter_soul_y, 454);
		}
		if encounter_time == 45
		{
			encounter_state++;
			encounter_time = 0;
		}
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