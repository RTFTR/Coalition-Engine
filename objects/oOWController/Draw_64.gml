var ItemCount = Item_Count(),
	CellCount = Cell_Count(),
	input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
	input_cancel = input_check_pressed("cancel"),
	input_confirm = input_check_pressed("confirm");
// Check if a Overworld Dialog is occuring
if dialog_exists
{
	//Dialog Box drawing
	oOWPlayer.moveable = false;
	var dialog_box_x = 30,
		dialog_box_y = (dialog_is_down ? 320 : 10),
		dialog_width = 580,
		dialog_height = 150,
		dialog_box_frame = 5;
	draw_set_color(c_white);
	draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width,
					dialog_box_y + dialog_height, false);
	draw_set_color(c_black);
	draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame,
					dialog_box_x + dialog_width - dialog_box_frame,
					dialog_box_y + dialog_height - dialog_box_frame, false);
	
	//Dialog Text drawing
	var dis = 0;
	if dialog_sprite != -1
	{
		dis = 95;
		var spr_w = sprite_get_width(dialog_sprite),
			spr_h = sprite_get_height(dialog_sprite),
			sprite_dis_x = sprite_get_xoffset(dialog_sprite) - spr_w / 2,
			sprite_dis_y = sprite_get_yoffset(dialog_sprite) - spr_h / 2;
		draw_sprite_ext(dialog_sprite, dialog_sprite_index, dialog_box_x + 60 + sprite_dis_x, dialog_box_y + 80 + sprite_dis_y, 80 /spr_w, 80 / spr_h, 0, c_white, 1);
	}
	__text_writer.starting_format(dialog_font, c_white)
	__text_writer.draw(dialog_box_x + 25 + dis, dialog_box_y + 20, dialog_typist)
	
	//Check if the dialog is currently an option and draw if question is asked and buffer time has expired
	if dialog_option and dialog_typist.get_state() == 1
	{
		if option_buffer > 0 option_buffer--;
		if !option_buffer
		{
			option_text.draw(dialog_box_x + 45, dialog_box_y + 110, option_typist)
			if input_horizontal != 0
				option = posmod(option + input_horizontal, option_amount);
			draw_sprite_ext(sprSoul, 0, dialog_box_x + option_length[option], dialog_box_y + 110, 1, 1, 90, c_red, 1);
		}
	}
		
	//Dialog skipping
	if input_cancel and global.TextSkipEnabled
	{
		__text_writer.page(__text_writer.get_page_count() - 1);
		dialog_typist.skip_to_pause();
	}
	if dialog_typist.get_state() == 1 and __text_writer.get_page() < (__text_writer.get_page_count() - 1)
		__text_writer.page(__text_writer.get_page() + 1)
	if dialog_typist.get_state() == 1
	{
		if input_confirm
		{
			dialog_exists = false;
			is_saving = Saving;
			Choice = 0;
			oOWPlayer.moveable = true;
			if dialog_option
			{
				//Executes the event of the option
				option_event[option]();
			}
		}
	}
}

// Save UI
if is_saving
{
	WaitTime++;
	oOWPlayer.moveable = false;
	var dialog_box_x = 108,
		dialog_box_y = 118,
		dialog_width = 424,
		dialog_height = 174,
		dialog_box_frame = 5;
	//Box UI drawing
	draw_set_color(c_white);
	draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width,
					dialog_box_y + dialog_height, false);
	draw_set_color(c_black);
	draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame,
					dialog_box_x + dialog_width - dialog_box_frame,
					dialog_box_y + dialog_height - dialog_box_frame, false);
	
	draw_set_color(Saved ? c_yellow : c_white);
	draw_set_font(fnt_dt_sans);
	draw_set_halign(fa_left);
	draw_text(140, 140, global.data.name);
	draw_text(295, 140, "LV " + string(global.data.lv));
	var time = global.timer,
		second = time div 60,
		minute = string(second div 60);
	second %= 60;
	second = string(second);
	draw_text(423, 140, minute + ":" + (real(second) < 10 ? "0" : "") + second);
	//Placeholer room name getter
	draw_text(140, 180, room_get_name(room));
	if !Saved
	{
		if input_horizontal != 0
		{
			audio_play(snd_menu_switch);
			Choice = posmod(Choice + input_horizontal, 2);
		}
		var SoulAlpha = abs(dsin(global.timer)) + 0.3;
		draw_sprite_ext(sprSoul, 0, 151 + Choice * 180, 255, 1, 1, 90, c_red, SoulAlpha);
		draw_text(170, 240, "Save");
		draw_text(350, 240, "Return");
		if input_confirm and WaitTime > 5
		{
			WaitTime = 0;
			if !Choice
			{
				Saved = 1;
				audio_play(snd_save);
			}
			else
			{
				Saved = 0;
				is_saving = false;
				Saving = false;
				Choice = 0;
				oOWPlayer.moveable = true;
				oOWController.menu_disable = false;
				oOWCollision.Collided = false;
			}
		}
	}
	if Saved == 1
	{
		if input_confirm and WaitTime
		{
			Choice = 0;
			is_saving = false;
			Saving = false;
			oOWPlayer.moveable = true;
			oOWController.menu_disable = false;
			oOWCollision.Collided = false;
		}
	}
}

#region // Menu Overworld
	var CamPos = [camera_get_view_x(view_camera[0]),  camera_get_view_y(view_camera[0])],
		// Check if the menu should display more on top or more on bottom, depending on player's position
		menu_at_top = oOWPlayer.y < CamPos[1] + camera_get_view_height(view_camera[0]) / 2 + 10;
	
	#region // The "Name - LV - HP - G" box

	// Position and side elements
	var ui_box_x = menu_ui_x + 6,
		ui_box_y = menu_at_top ? 45 : 328,
		ui_width = 130,
		ui_height = 98,
		ui_box_frame = 5

	// Box Drawing
	draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + ui_width - 1, ui_box_y + ui_height - 1, ui_box_frame,,,,, true);

	// String var declaration
	var name =			string(global.data.name),
		lv =			string(global.data.lv),
		hp =			string(global.hp),
		max_hp =		string(global.hp_max),
		gold =			string(global.data.Gold);

	// String drawing
	draw_set_color(c_white);

	draw_text_scribble(ui_box_x + 12, ui_box_y + 3, "[fnt_dt_sans]" + name);


	draw_set_font(fnt_cot);
	draw_text(ui_box_x + 12, ui_box_y + 36, "LV  " + lv);
	draw_text(ui_box_x + 12, ui_box_y + 54, "HP  " + hp + "/" + max_hp);

	// Toby Fox method because the number in Gold is not aligned correctly with spaces
	var ui_num_x = ui_box_x + 12 + string_width("LV  ");
	draw_text(ui_box_x + 12, ui_box_y + 72, "G");
	draw_text(ui_num_x, ui_box_y + 72, gold);

	#endregion

	#region // The "ITEM - STAT - CELL" box with their respective elements

	// Position and side elements for the box
	var	ui_box_x = menu_ui_x + 6,
		ui_box_y = 174,
		ui_width = 130,
		ui_height = 136,
		ui_box_frame = 6;
	
	// Box Drawing
				draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + ui_width - 1, ui_box_y + ui_height - 1, ui_box_frame,,,,, true);

	// Menu Label
	var menu_label = ["ITEM","STAT","CELL"],
		menu_color =
			[
				[c_dkgray, c_white],
				[c_white, c_white],
				[c_black, c_white],
			],
		exist_check = [ItemCount, 1, CellCount];
	
		draw_set_font(fnt_dt_sans);
		for(var i = 0; i < 3; ++i)
		{
			draw_set_color(menu_color[i, bool(exist_check[i])]); // Check if the menu exists or not to proceed color
			draw_text(ui_box_x + 46, ui_box_y + 15 + i * 36, menu_label[i]);
		}


	#region // Drawing the box for each state

		// Var declaration
		var ui_box_x = 194,
			ui_width = 334,
			ui_box_frame = 6;

		#region // ITEM state
			if menu_ui_y[MENU_MODE.ITEM] > -500
			{
				var ui_height = 350,
					ui_box_y = menu_ui_y[MENU_MODE.ITEM] + 6;
	
				// Box Drawing
				draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + ui_width - 1, ui_box_y + ui_height - 1, ui_box_frame,,,, 0.4, true);
	
				// Item text drawing
				draw_set_font(fnt_dt_sans);
				draw_set_color(c_white);

				for (var i = 0, n = ItemCount; i < n; ++i)
					draw_text(232, ui_box_y + 23 + i * 32, item_name[i]);

				// Item function
				var gap = [0, 96, 114],
					menu_text = ["USE", "INFO", "DROP"];
				draw_set_font(fnt_dt_sans);
				draw_set_color(c_white);

				for(var i = 0; i < 3; i++)
					draw_text(234 + Sigma(gap, 0, i), ui_box_y + 303, menu_text[i]);
			}
		#endregion

		#region // STAT state
			if menu_ui_y[MENU_MODE.STAT] > -480
			{
				var ui_height = 406,
					ui_box_y = menu_ui_y[MENU_MODE.STAT] + 6;
				
				// Box Drawing
				draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + ui_width - 1, ui_box_y + ui_height - 1, ui_box_frame,,,, 0.4, true);
	
				// Stat text drawing
				draw_set_font(fnt_dt_sans);
				draw_set_color(c_white);
				draw_text(216, ui_box_y + 27,"''" + global.data.name + "''");
				draw_text(216, ui_box_y + 87, "LV " + lv);
				draw_text(216, ui_box_y + 119, "HP " + hp + " / "+ max_hp);
				draw_text(216, ui_box_y + 183, "AT " + string(global.player_base_atk) + " (" + string(global.player_attack) + ")");
				draw_text(216, ui_box_y + 215, "DF " + string(global.player_base_def) + " (" + string(global.player_def) + ")");
				draw_text(384, ui_box_y + 183, "EXP: " + string(global.data.Exp));
				draw_text(384, ui_box_y + 215, "NEXT: " + string(Player_GetExpNext()));
				draw_text(216, ui_box_y + 273, "WEAPON: " + string(global.data.AttackItem));
				draw_text(216, ui_box_y + 305, "ARMOR: " + string(global.data.DefenseItem));
				draw_text(216, ui_box_y + 347, "GOLD: " + gold);
			}
		#endregion

		#region // CELL state
			if menu_ui_y[MENU_MODE.CELL] > -500
			{
				var ui_height = 258,
					ui_box_y = menu_ui_y[MENU_MODE.CELL] + 6;
	
				// Box Drawing
				draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + ui_width - 1, ui_box_y + ui_height - 1, ui_box_frame,,,, 0.4, true);
		
				// Cell text drawing
				draw_set_font(fnt_dt_sans);
				draw_set_color(c_white);
				for (var i = 1, n = CellCount; i <= n; ++i)
					draw_text(232, ui_box_y - 9 + i * 32, Cell_GetName(i));
			}
		#endregion

	#endregion

	// Check if player has opened a Box
	if box_mode
	{
		oOWPlayer.moveable = false;
		var dialog_box_x = 20,
			dialog_box_y = 20,
			dialog_width = 600,
			dialog_height = 440,
			dialog_box_frame = 5;
		//Box UI drawing
		draw_set_color(c_white);
		draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width,
						dialog_box_y + dialog_height, false);
		draw_set_color(c_black);
		draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame,
						dialog_box_x + dialog_width - dialog_box_frame,
						dialog_box_y + dialog_height - dialog_box_frame, false);
		draw_set_color(c_white);
		draw_line_width(320, 90, 320, 390, 5);
		draw_set_font(fnt_dt_sans);
		draw_set_halign(fa_center);
		//Box Text drawing
		draw_text(170, 35, "INVENTORY");
		draw_text(470, 35, "BOX");
		draw_text(320, 410, "Press [X] to Finish");
		draw_set_halign(fa_left);
		Item_Info_Load();
	
		for (var i = 0, n = ItemCount; i < n; ++i)
			draw_text(80, 70 + i * 35, item_name[i]);
		
		for (var i = n; i < 8; ++i)
		{
			draw_set_color(c_red);
			draw_line_width(95, 85 + i * 35, 245, 85 + i * 35, 2);
		}
		//Item Text / line drawing
		for (var i = 0; i < 10; ++i)
		{
			if i < 8
			{
				if global.Box[Box_ID, i]
				{
					Box_Info_Load();
					draw_set_color(c_white);
					draw_text(380, 70 + i * 35, box_name[i]);
				}
				else
				{
					draw_set_color(c_red);
					draw_line_width(395, 85 + i * 35, 545, 85 + i * 35, 2);
				}
			}
			else
			{
				draw_set_color(c_red);
				draw_line_width(395, 85 + i * 35, 545, 85 + i * 35, 2);
			}
		}
	}
	// Drawing the soul over everything
	draw_sprite_ext(sprSoulMenu, 0, menu_soul_pos[0], menu_soul_pos[1], 1, 1, 0, c_red, menu_soul_alpha);

	#endregion
#endregion

#region // Debugger
DrawDebugUI();
#endregion

