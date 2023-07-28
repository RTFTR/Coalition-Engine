	

/////@desc Settings
//var MouseLeft = mouse_check_button_pressed(mb_left),
//	MouseRight = mouse_check_button_pressed(mb_right)
////Draw main settings box (Left)
//var X = settings_x;

//draw_set_color(c_white);
//draw_rectangle(X, 10, X + 300, 470, false);

//draw_set_color(c_black);
//draw_rectangle(X + 5, 15, X + 295, 465, false);

//draw_set_color(c_white);
//draw_set_font(fnt_dt_sans);
////Sets target so it won't draw off the rectangle
//surface_set_target(SettingSurface);
////Draw the text of settings
//for(var i = 0, n = array_length(SettingName), SettingNum = -1; i < n; i++)
//{
//	var SettingRectCol = c_white,
//		TextY = SettingY + i * 40,
//		MouseInSettingBox = point_in_rectangle(mouse_x, mouse_y, X + 10, TextY - 10, X + 290, TextY + 20);
//	if MouseInSettingBox
//	{
//		if !SettingSoundIsPlayed
//		{
//			//audio_play(snd_menu_switch);
//			SettingSoundIsPlayed = true;
//		}
//		SettingRectCol = c_yellow;
//		SettingNum = i;
//		Setting = i;
//		if i != 4 SelectingKey = false;
//	}
//	//Draws the rectangle of each text
//	draw_rectangle_width(X + 10, TextY - 10, X + 290, TextY + 20, 3, SettingRectCol);
	
//	//Text and color
//	var SettingTextCol = merge_color(c_white, SettingRectCol, abs(dsin(global.timer * 2)));
//	draw_text_transformed_color(X + 20, TextY, SettingName[i], 0.6, 0.6, 0, SettingTextCol, SettingTextCol,
//	SettingTextCol,SettingTextCol, 1);
//}
//surface_reset_target();
//draw_surface_part(SettingSurface, X + 5, 45, 290, 420, X + 5, 45);
//surface_free(SettingSurface);

////Check whether the cursor is hovering on the small rectangles
//TextY = SettingY + SettingNum * 40;
//var CursorRectCheck = point_in_rectangle(mouse_x, mouse_y, X + 10, TextY - 10, X + 290, TextY + 20);
//if (input_binding_scan_in_progress()) CursorRectCheck = false;
//if !CursorRectCheck
//	SettingSoundIsPlayed = false;

////Draw setting description box (Right)
//X = SettingDescX;
//draw_set_halign(fa_right);
//draw_set_color(c_white);
//draw_rectangle(X, 310, X - 240, 470, false);

//draw_set_color(c_black);
//draw_rectangle(X - 5, 315, X - 235, 465, false);

//draw_set_halign(fa_left);
//draw_set_color(c_white);
//if SettingNum != -1
//{
//	MouseInSetting = true;
//	var TextX = X - 240 + 17,
//		FinalText = SettingDesc[SettingNum],
//		FinalVar = (is_bool(SettingVar[SettingNum]) ? 
//				//If it's a bool
//				(SettingVar[SettingNum] ? "Enabled" : "Disabled")
//				//If it's a value, string it
//				: string(SettingVar[SettingNum]));
//	if SettingNum != 4
//		FinalText += "\n\nCurrent: " + FinalVar
	
//	draw_text_transformed(TextX, 330, FinalText, 0.65, 0.65, 0);
//	if CursorRectCheck
//	{
//		if is_bool(SettingVar[SettingNum])
//		{
//			if MouseLeft
//			{
//				SettingVar[SettingNum] = !SettingVar[SettingNum];
//				Save_Settings();
//				audio_play(snd_menu_confirm);
//			}
//		}
//		else if is_real(SettingVar[SettingNum])
//		{
//			var input = input_check_pressed("right") - input_check_pressed("left"),
//				precise = keyboard_check(vk_shift);
//			SettingVar[SettingNum] += input * (precise ? 1 : SettingVarChange[SettingNum]);
//			if input != 0
//			{
//				Save_Settings();
//				audio_play(snd_menu_confirm);
//			}
//		}
//		else if is_array(SettingVar[SettingNum])
//		{
//			if SettingNum == 4
//			{
//				if MouseLeft SelectingKey = true;
//				if MouseRight SelectingKey = false;
//			}
//		}
//		else if is_undefined(SettingVar[SettingNum])
//		{
//			switch SettingNum
//			{
//				case 5:
//					array_push(MusicList, audio_play_sound(Musics[0], 0, 1, 2000, 60));
//				break
//			}
//		}
//	}
//}
//else
//{
//	MouseInSetting = false;
//}

////Key rebind box
//X = KeySelX;
//draw_set_halign(fa_right);
//draw_set_color(c_white);
//draw_rectangle(X, 10, X - 240, 300, false);

//draw_set_color(c_black);
//draw_rectangle(X - 5, 15, X - 235, 295, false);
//var keytexts =
//[
//	"Up", "Down", "Left", "Right",
//	"Confirm", "Cancel", "Settings",
//];
//draw_set_color(c_white);

////Sets target so it won't draw off the rectangle
//surface_set_target(KeySurface);

//if KeyIsSetting
//{
//	if (!input_binding_scan_in_progress())
//	    input_binding_scan_start(function(_binding)
//	    {
//			if keyboard_check_pressed(vk_escape)
//			{
//				input_binding_scan_abort();
//				KeyIsSetting = false;
//				KeySet = -1;
//				KeySetVerb = "";
//				exit;
//			}
//	        input_binding_set_safe(KeySetVerb, _binding);
//			KeyIsSetting = false;
//			KeySet = -1;
//			KeySetVerb = "";
//			Save_Settings();
//	    });
//}
//for(var i = 0; i < 7; i++)
//{
//	draw_set_valign(fa_middle);
//	draw_set_halign(fa_left);
//	draw_text_transformed(X - 240 + 17, KeyTextY + i * 30, keytexts[i], 0.6, 0.6, 0);
//	var KeyVerb = ["up", "down", "left", "right", "confirm", "cancel", "menu"]
//	var KeyText = input_binding_get_icon(input_binding_get(KeyVerb[i]));
//	if string_starts_with(KeyText, "arrow ")
//	{
//		var StrLen = string_length(KeyText);
//		KeyText = string_copy(KeyText, 7, StrLen - 6);
//	}
//	var StartLetter = string_upper(string_copy(KeyText, 1, 1));
//	var StrLen = string_length(KeyText);
//	KeyText = StartLetter + string_copy(KeyText, 2, StrLen - 1);
//	draw_set_halign(fa_center);
//	var CenterOfTextX = X - 80 + 17,
//		CenterOfTextY = KeyTextY + i * 30,
//		TextWidth = string_width(KeyText) / 2,
//		TextHeight = string_height(KeyText) / 2,
//		MouseInText = point_in_rectangle(mouse_x, mouse_y, CenterOfTextX - TextWidth, CenterOfTextY - TextHeight,
//				CenterOfTextX + TextWidth, CenterOfTextY + TextHeight),
//		Color = MouseInText ? c_yellow : c_white;
//	if MouseInText
//	{
//		if MouseLeft
//		{
//			KeySet = i;
//			KeySetVerb = KeyVerb[i];
//			KeyIsSetting = true;
//			audio_play(snd_menu_confirm);
//		}
//	}
//	KeyScale[i] = lerp(KeyScale[i], (KeySet == i) ? 1.2 : 0.6, 0.18);
//	draw_text_transformed_color(CenterOfTextX, CenterOfTextY, KeyText, KeyScale[i], KeyScale[i], 0,
//								Color, Color, Color, Color, 1);
//}
//surface_reset_target();
//draw_surface_part(KeySurface, X - 240 + 17, 20, 200, 280, X - 240 + 17, 20);
//surface_free(KeySurface);

//draw_set_halign(fa_left);
//draw_set_valign(fa_top);
//draw_set_color(c_white);

////Upper background coverage
//X = settings_x;
//draw_set_color(c_black);
//draw_rectangle(X + 5, 15, X + 295, 70, false);

//draw_set_halign(fa_center);
//draw_set_color(c_white);
////Draw the texts
//draw_text_transformed(X + 150, 25, "Settings\n-----------------------", 0.85, 0.85, 0);


//draw_set_halign(fa_left);

////Mouse drawing
//draw_sprite_ext(sprSoul, 0, mouse_x, mouse_y, 1, 1, -135, c_red, 1);