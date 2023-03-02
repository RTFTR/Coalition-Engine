var input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
	input_vertical = input_check_pressed("down") - input_check_pressed("up"),
	input_confirm = input_check_pressed("confirm"),
	input_cancel = input_check_pressed("cancel");
	
var state = (menu_state == INTRO_MENU_STATE.NAME_CHECKING or menu_state == INTRO_MENU_STATE.NAME_CONFIRM);
naming_alpha[0] += ( (!state ? 1 : 0) - naming_alpha[0] ) * 0.1;
naming_alpha[1] += ( (state ? 1 : 0) - naming_alpha[1] ) * 0.1;
name_y += ( (!state ? 110 : 230) - name_y) * 0.05;
name_scale += ( (!state ? 1 : 2.5) - name_scale) * 0.05;

if menu_state == INTRO_MENU_STATE.LOGO
{
	if input_confirm
		menu_state = INTRO_MENU_STATE.FIRST_TIME;
		//room_goto(room_battle)
}

else if menu_state == INTRO_MENU_STATE.FIRST_TIME
{
	if input_vertical != 0 menu_choice[0] = posmod(menu_choice[0] + input_vertical, 2);
	else if input_confirm != 0
	{
		if menu_choice[0] == 0 menu_state = INTRO_MENU_STATE.NAMING; // Choose [Begin Game]
		else if menu_choice[0] != 0 menu_state = INTRO_MENU_STATE.SETTINGS; // Choose [Settings]
	}
}

else if menu_state == INTRO_MENU_STATE.NAMING // Holy shit this needs optimization! Mechanic from TML engine
{
	#region // Switching between letters and options
		if input_horizontal != 0
		{
			if naming_choice >= 1 and naming_choice <= 52 // Switching from [A] to [z]
			{
				naming_choice += input_horizontal;
				naming_choice = clamp(naming_choice, 1, 52);
			}
			else if naming_choice >= 53 and naming_choice <= 55 // Switching between [Quit] [Backspace] [Done]
			{
				naming_choice += input_horizontal;
				if naming_choice >= 56 naming_choice = 53;
				else if naming_choice <= 52 naming_choice = 55;
				naming_choice = clamp(naming_choice, 53, 55);
				
			}
		}
		
		if input_vertical == 1 // Input Down
		{
			if (naming_choice >= 20 and naming_choice <= 21) naming_choice += 12; // [T U] to [f g]
			else if (naming_choice >= 22 and naming_choice <= 26) naming_choice += 5; // [V W X Y Z] to [a b c d e]
			else if (naming_choice >= 46 and naming_choice <= 47) naming_choice = 55; // [t u] to [Done]
			else if (naming_choice >= 48 and naming_choice <= 49) naming_choice = 53; // [v w] to [Quit]
			else if (naming_choice >= 50 and naming_choice <= 52) naming_choice = 54; // [x y z] to [Backspace]
			else if (naming_choice == 53) naming_choice = 1; // [Quit] to [A]
			else if (naming_choice == 54) naming_choice = 3; // [Backspace] to [C]
			else if (naming_choice == 55) naming_choice = 6; // [Done] to [F]
			else naming_choice += 7;
		}
		else if input_vertical == -1 // Input Up
		{
			if (naming_choice >= 1 and naming_choice <= 2) naming_choice = 53; // [A B] to [Quit]
			else if (naming_choice >= 3 and naming_choice <= 5) naming_choice = 54; // [C D E] to [Backspace]
			else if (naming_choice >= 6 and naming_choice <= 7) naming_choice = 55; // [F G] to [Done]
			else if (naming_choice >= 32 and naming_choice <= 33) naming_choice -= 12; // [f g] to [T U]
			else if (naming_choice >= 27 and naming_choice <= 31) naming_choice -= 5; // [a b c d e] to [V W X Y Z]
			else if (naming_choice == 53) naming_choice = 48; // [Quit] to [v]
			else if (naming_choice == 54) naming_choice = 50; // [Backspace] to [x]
			else if (naming_choice == 55) naming_choice = 46; // [Done] to [t]
			else naming_choice -= 7;
		}
	#endregion
	
	#region // Adding, removing letters from name and options function
	
		var name_length = string_length(name);
		if input_confirm != 0
		{
			if name_length < name_max_length
			{
				if naming_choice >= 1 and naming_choice <= 26
					name += string_char_at(naming_letter[0], naming_choice);
				else if naming_choice >= 27 and naming_choice <= 52
					name += string_char_at(naming_letter[1], naming_choice - 26);
			}
			if naming_choice == 53 menu_state = INTRO_MENU_STATE.FIRST_TIME; // [Quit] //menu_state = INTRO_MENU_STATE.LOGO;
			// The quit state should check if the game is opened for the first time
			// or not to determine which state to go
			// But I'm out of time so you do!
			
			if naming_choice == 54 and name_length > 0 name = string_delete(name, name_length, 1); // [Backspace]
			if naming_choice == 55 and name_length > 0 menu_state = INTRO_MENU_STATE.NAME_CHECKING; // [Done]

		}
		if input_cancel != 0 and name_length > 0 name = string_delete(name, name_length, 1);
		
	#endregion
}
else if menu_state == INTRO_MENU_STATE.NAME_CHECKING // Name checking thingy
{
	if input_horizontal != 0 
		name_confirm = posmod(name_confirm + input_horizontal, 2);
	
	if input_confirm != 0
	{
		if !name_confirm menu_state = INTRO_MENU_STATE.NAMING
		else 
		{
			menu_state = INTRO_MENU_STATE.NAME_CONFIRM;
			name_confirm = true;
			name_check = true;
			oGlobal.fader_color = c_white;
			TweenFire(oGlobal, EaseLinear, TWEEN_MODE_ONCE, false, 0, 240, "fader_alpha", 0, 1);
			alarm[0] = 240; // I believe this can be handled by call_later but me lazy and shortage in time af
		}
	}
	
}


//hint += 1/60;
//if !surface_exists(KeySurface) KeySurface = surface_create(640, 480);
//if !surface_exists(SettingSurface) SettingSurface = surface_create(640, 480);

////Settings
//if menu_state == INTRO_MENU_STATE.LOGO
//{
//	SettingVar[0] = clamp(SettingVar[0], 0, 100);
//	SettingVar[1] = bool(SettingVar[1]);
//	SettingVar[2] = bool(SettingVar[2]);
//	SettingVar[3] = bool(SettingVar[3]);
//	SettingVar[3] = true;
//	global.Volume = SettingVar[0];
//	global.ShowFPS = SettingVar[1];
//	global.CompatibilityMode = SettingVar[2];
//	global.easy = SettingVar[3];
//	audio_master_gain(SettingVar[0] / 100);

//	//Title drawing things
//	var RainbowY = .5 - !is_setting * 3,
//		Logoheight = string_height(LogoText) + 100;

//	CubePos = 
//	[
//		lerp(CubePos[0], is_setting ? 510 : 320, LerpSpeed),
//		lerp(CubePos[1], is_setting ? 50 + Logoheight : 100, LerpSpeed)
//	];

//	TitleScale = lerp(TitleScale, is_setting ? 0.5 : 1, LerpSpeed);

//	Titlepos = 
//	[
//		lerp(Titlepos[0], is_setting ? 510 : 320, LerpSpeed),
//		lerp(Titlepos[1], is_setting ? 50 : 200, LerpSpeed)
//	];

//	DescX = lerp(DescX, is_setting ? 130 : 320, LerpSpeed);


//	if instance_exists(RainbowFuture)
//		RainbowFuture.y_offset0 = lerp(RainbowFuture.y_offset0, RainbowY, LerpSpeed);

//	//Set noise to random
//	Effect_SetParam(shdNoise, "seed", random(100));


//	//Setting lerping
//	if !is_setting {
//		SelectingKey = false;
//		settings_x = lerp(settings_x, -480, LerpSpeed);
//		if input_check_pressed("confirm") and !fading
//		{
//			fading = true;
//			Fade_Out(FADE.CIRCLE, 40, 10);
//			var _handle = call_later(40, time_source_units_frames, function()
//			{
//				room_goto(room_overworld);
//			});
//		}
//		//if input_check_pressed("confirm") room_goto(room_battle);
//		if keyboard_check_pressed(ord("R")) and !fading
//		{
//			global.battle_encounter = 2;
//			room_goto(room_battle);
//		}
//		//if keyboard_check_pressed(vk_space) {global.battle_encounter = 1; room_goto(room_battle);}
//		if keyboard_check_pressed(vk_space) and !fading
//		{
//			fading = true;
//			Fade_Out(FADE.LINES, 30, 10);
//			var _handle = call_later(30, time_source_units_frames, function()
//			{
//			global.battle_encounter = (global.easy ? 1 : 3);
//			global.battle_encounter = 3;
//			room_goto(room_battle);
//			});
//		}
//		if keyboard_check_pressed(ord("Y")) and !fading
//		{
//			var file;
//			file = get_open_filename_ext("file|*.json", "", working_directory + "/Replays", "Choose Replay");
//			if file != ""
//			{
//				PlayReplay(file);
//			}
//		}
//	}
//	else
//	{
//		settings_x = lerp(settings_x, 10, LerpSpeed);
//		var input = input_check_pressed("right") - input_check_pressed("left"),
//			input_v = input_check_pressed("down") - input_check_pressed("up"),
//			InputH_h = input_check("right") - input_check("left"),
//			InputH_v = input_check("down") - input_check("up"),
//			Scroll = mouse_wheel_up() - mouse_wheel_down();
//		if (!input_binding_scan_in_progress())
//		if point_in_rectangle(mouse_x, mouse_y, settings_x + 5, 15, settings_x + 295, 465) and !KeyIsSetting
//			SettingYTarget += Scroll * 10;
//		if point_in_rectangle(mouse_x, mouse_y, KeySelX - 235, 15, KeySelX - 5, 295)
//		{
//			KeyTextYTarget += Scroll * 20;
//		}
//		KeyTextY = lerp(KeyTextY, KeyTextYTarget, 0.12);
//		KeyTextY = clamp(KeyTextY, -135, 30);
//		SettingY = lerp(SettingY, SettingYTarget, 0.12);
//		SettingY = clamp(SettingY, 85 - 60, 85);
//	}
//	SettingDescX = lerp(SettingDescX, MouseInSetting ? 630 : 1000, LerpSpeed);
//	KeySelX = lerp(KeySelX, SelectingKey ? 630 : 1000, LerpSpeed);

//	//global.battle_encounter = 3; room_goto(room_battle);
//	if input_check_pressed("menu")
//	{
//		is_setting = !is_setting;
//		input_binding_scan_abort();
//		if array_length(MusicList) > 0
//			audio_sound_gain(MusicList[0], 0, 1000);
//	}

//	var MouseLeft = mouse_check_button_pressed(mb_left),
//		MouseRight = mouse_check_button_pressed(mb_right)
//	if !global.CompatibilityMode
//	{
//		if MouseLeft
//		{
//			effect_create_above(ef_ring, mouse_x, mouse_y, 1, c_aqua);
//		}
//	}
//}

