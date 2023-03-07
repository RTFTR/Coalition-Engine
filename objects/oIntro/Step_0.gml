var input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
	input_vertical = input_check_pressed("down") - input_check_pressed("up"),
	input_confirm = input_check_pressed("confirm"),
	input_cancel = input_check_pressed("cancel");
	
var state = (menu_state == INTRO_MENU_STATE.NAME_CHECKING or menu_state == INTRO_MENU_STATE.NAME_CONFIRM);
naming_alpha[0] += (real(!state) - naming_alpha[0]) * 0.15;
naming_alpha[1] += (real(state) - naming_alpha[1]) * 0.15;
name_y += ((state ? 230 : 110) - name_y) * 0.12;
name_scale += ((state ? 2.5 : 1) - name_scale) * 0.12;

switch menu_state
{
	case INTRO_MENU_STATE.LOGO:
		if input_confirm
			menu_state = INTRO_MENU_STATE.FIRST_TIME;
			//room_goto(room_battle)
	break
	case INTRO_MENU_STATE.FIRST_TIME:
		name = "";
		if input_vertical != 0 menu_choice[0] = posmod(menu_choice[0] + input_vertical, 2);
		else if input_confirm
		{
			//Choose whether it goes to naming or settings
			menu_state = menu_choice[0] == 0 ? INTRO_MENU_STATE.NAMING : INTRO_MENU_STATE.SETTINGS;
		}
	break

	case INTRO_MENU_STATE.NAMING: // Holy shit this needs optimization! Mechanic from TML engine
		#region // Switching between letters and options
			if input_horizontal != 0
			{
				audio_play(snd_menu_switch);
				if naming_choice >= 1 and naming_choice <= 52 // Switching from [A] to [z]
				{
					naming_choice = clamp(naming_choice + input_horizontal, 1, 52);
					if naming_choice == 52 naming_choice++;
				}
				else if naming_choice >= 53 and naming_choice <= 55 // Switching between [Quit] [Backspace] [Done]
				{
					naming_choice = posmod(naming_choice + input_horizontal - 53, 3) + 53;
				
				}
			}
		
			if input_vertical == 1 // Input Down
			{
				audio_play(snd_menu_switch);
				if (naming_choice >= 20 and naming_choice <= 21) naming_choice += 12; // [T U] to [f g]
				// [V W X Y Z] to [a b c d e]
				else if (naming_choice >= 22 && naming_choice <= 26) naming_choice += 5;
				else if (naming_choice >= 46 && naming_choice <= 52)
				{
					// [t u] to [Done]
					// [v w] to [Quit]
					// [x y z] to [Backspace]
					naming_choice = 53 + (naming_choice >= 50) + (naming_choice <= 47) * 2;
				}
				else if (naming_choice >= 53)
				{
					// [Quit] to [A]
					// [Backspace] to [C]
					// [Done] to [F]
					naming_choice = max((naming_choice - 53) * 3, 1);
				}
				else naming_choice += 7;
			}
			else if input_vertical == -1 // Input Up
			{
				audio_play(snd_menu_switch);
				// [A B] to [Quit]
				// [C D E] to [Backspace]
				// [F G] to [Done]
				if naming_choice >= 1 and naming_choice <= 7
					naming_choice = (naming_choice div 3) + 53;
				// [a b c d e] to [V W X Y Z]
				else if (naming_choice >= 27 and naming_choice <= 31) naming_choice -= 5;
				// [f g] to [T U]
				else if (naming_choice >= 32 and naming_choice <= 33) naming_choice -= 12;
				else if (naming_choice >= 53)
				{
					// [Quit] to [v]
					// [Backspace] to [x]
					// [Done] to [t]
					var temp_choice = (naming_choice - 53) * 2;
					if temp_choice == 4 temp_choice -= 6;
					naming_choice = 48 + temp_choice;
				}
				else naming_choice -= 7;
			}
		#endregion
	
		#region // Adding, removing letters from name and options function
	
			var name_length = string_length(name);
			if input_confirm
			{
				if name_length < name_max_length
				{
					audio_play(snd_menu_confirm);
					var text = string_char_at(naming_letter[0], ((naming_choice - 1) % 26) + 1);
					if naming_choice >= 1 and naming_choice <= 52
						name += (naming_choice <= 26 ? text : string_lower(text));
					//Uppercase or lowercase letters
				}
				if naming_choice == 53 menu_state = INTRO_MENU_STATE.FIRST_TIME; // [Quit] //menu_state = INTRO_MENU_STATE.LOGO;
				// The quit state should check if the game is opened for the first time
				// or not to determine which state to go
				// But I'm out of time so you do!
				
				if name_length > 0
				{
					if naming_choice == 55 menu_state = INTRO_MENU_STATE.NAME_CHECKING; // [Done]
				}

			}
			if name_length > 0 and (input_cancel or (input_confirm and naming_choice == 54))
				name = string_delete(name, name_length, 1); //[Backspace]
		
		#endregion
	break
	case INTRO_MENU_STATE.NAME_CHECKING: // Name checking thingy
		if input_horizontal != 0
		{
			audio_play(snd_menu_switch);
			name_confirm = posmod(name_confirm + input_horizontal, 2);
		}
		if input_confirm != 0
		{
			audio_play(snd_menu_confirm);
			if !name_confirm menu_state = INTRO_MENU_STATE.NAMING
			else 
			{
				audio_play(snd_cymbal)
				menu_state = INTRO_MENU_STATE.NAME_CONFIRM;
				name_confirm = true;
				name_check = true;
				Fader_Fade(0, 1, 300, 0, c_white);
				var _handle = call_later(310, time_source_units_frames, function()
				{
					global.data.name = name;
					Fader_Fade(1, 0, 20);
					//room_goto_next();
					room_goto(room_overworld);

				});
			}
		}
	break
	case INTRO_MENU_STATE.SETTINGS:
		if input_cancel game_restart();
	break
}


/*hint += 1/60;
if !surface_exists(KeySurface) KeySurface = surface_create(640, 480);
if !surface_exists(SettingSurface) SettingSurface = surface_create(640, 480);

//Settings
if menu_state == INTRO_MENU_STATE.LOGO
{
	SettingVar[0] = clamp(SettingVar[0], 0, 100);
	SettingVar[1] = bool(SettingVar[1]);
	SettingVar[2] = bool(SettingVar[2]);
	SettingVar[3] = bool(SettingVar[3]);
	SettingVar[3] = true;
	global.Volume = SettingVar[0];
	global.ShowFPS = SettingVar[1];
	global.CompatibilityMode = SettingVar[2];
	global.easy = SettingVar[3];
	audio_master_gain(SettingVar[0] / 100);

	//Title drawing things
	var RainbowY = .5 - !is_setting * 3,
		Logoheight = string_height(LogoText) + 100;

	CubePos = 
	[
		lerp(CubePos[0], is_setting ? 510 : 320, LerpSpeed),
		lerp(CubePos[1], is_setting ? 50 + Logoheight : 100, LerpSpeed)
	];

	TitleScale = lerp(TitleScale, is_setting ? 0.5 : 1, LerpSpeed);

	Titlepos = 
	[
		lerp(Titlepos[0], is_setting ? 510 : 320, LerpSpeed),
		lerp(Titlepos[1], is_setting ? 50 : 200, LerpSpeed)
	];

	DescX = lerp(DescX, is_setting ? 130 : 320, LerpSpeed);


	if instance_exists(RainbowFuture)
		RainbowFuture.y_offset0 = lerp(RainbowFuture.y_offset0, RainbowY, LerpSpeed);

	//Set noise to random
	Effect_SetParam(shdNoise, "seed", random(100));


	//Setting lerping
	if !is_setting {
		SelectingKey = false;
		settings_x = lerp(settings_x, -480, LerpSpeed);
		if input_check_pressed("confirm") and !fading
		{
			fading = true;
			Fade_Out(FADE.CIRCLE, 40, 10);
			var _handle = call_later(40, time_source_units_frames, function()
			{
				room_goto(room_overworld);
			});
		}
		//if input_check_pressed("confirm") room_goto(room_battle);
		if keyboard_check_pressed(ord("R")) and !fading
		{
			global.battle_encounter = 2;
			room_goto(room_battle);
		}
		//if keyboard_check_pressed(vk_space) {global.battle_encounter = 1; room_goto(room_battle);}
		if keyboard_check_pressed(vk_space) and !fading
		{
			fading = true;
			Fade_Out(FADE.LINES, 30, 10);
			var _handle = call_later(30, time_source_units_frames, function()
			{
			global.battle_encounter = (global.easy ? 1 : 3);
			global.battle_encounter = 3;
			room_goto(room_battle);
			});
		}
		if keyboard_check_pressed(ord("Y")) and !fading
		{
			var file;
			file = get_open_filename_ext("file|*.json", "", working_directory + "/Replays", "Choose Replay");
			if file != ""
			{
				PlayReplay(file);
			}
		}
	}
	else
	{
		settings_x = lerp(settings_x, 10, LerpSpeed);
		var input = input_check_pressed("right") - input_check_pressed("left"),
			input_v = input_check_pressed("down") - input_check_pressed("up"),
			InputH_h = input_check("right") - input_check("left"),
			InputH_v = input_check("down") - input_check("up"),
			Scroll = mouse_wheel_up() - mouse_wheel_down();
		if (!input_binding_scan_in_progress())
		if point_in_rectangle(mouse_x, mouse_y, settings_x + 5, 15, settings_x + 295, 465) and !KeyIsSetting
			SettingYTarget += Scroll * 10;
		if point_in_rectangle(mouse_x, mouse_y, KeySelX - 235, 15, KeySelX - 5, 295)
		{
			KeyTextYTarget += Scroll * 20;
		}
		KeyTextY = lerp(KeyTextY, KeyTextYTarget, 0.12);
		KeyTextY = clamp(KeyTextY, -135, 30);
		SettingY = lerp(SettingY, SettingYTarget, 0.12);
		SettingY = clamp(SettingY, 85 - 60, 85);
	}
	SettingDescX = lerp(SettingDescX, MouseInSetting ? 630 : 1000, LerpSpeed);
	KeySelX = lerp(KeySelX, SelectingKey ? 630 : 1000, LerpSpeed);

	//global.battle_encounter = 3; room_goto(room_battle);
	if input_check_pressed("menu")
	{
		is_setting = !is_setting;
		input_binding_scan_abort();
		if array_length(MusicList) > 0
			audio_sound_gain(MusicList[0], 0, 1000);
	}

	var MouseLeft = mouse_check_button_pressed(mb_left),
		MouseRight = mouse_check_button_pressed(mb_right)
	if !global.CompatibilityMode
	{
		if MouseLeft
		{
			effect_create_above(ef_ring, mouse_x, mouse_y, 1, c_aqua);
		}
	}
}

