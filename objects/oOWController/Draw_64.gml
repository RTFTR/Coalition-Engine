//Check if a Overworld Dialog is occuring
if is_dialog
{
	//Dialog Box drawing
	oOWPlayer.char_moveable = false;
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
	text_writer.starting_format(dialog_font,c_white)
	text_writer.draw(dialog_box_x + 20, dialog_box_y + 20, dialog_typist)
	//Check if the dialog is currently an option (INCOMPLETE)
	if is_dialog_a_option
	{
		option_text.starting_format(dialog_font, c_white)
		option_text.draw(dialog_box_x + 20, dialog_box_y + 130, option_typist)
		if input_check_pressed("left") or input_check_pressed("right")
			option = !option;
		draw_sprite_ext(sprSoul, 0, dialog_box_x + 20 + Sigma(option_length, 0, option), 320, 1, 1, 0, c_red, 1);
	}
		
	//Dialog skipping
	if input_check_pressed("cancel")
	{
		text_writer.page(text_writer.get_page_count() - 1);
		dialog_typist.skip();
	}
	if dialog_typist.get_state() == 1 and text_writer.get_page() < (text_writer.get_page_count() - 1)
		text_writer.page(text_writer.get_page() + 1)
	if dialog_typist.get_state() == 1
	{
		if input_check_pressed("confirm")
		{
			is_dialog = false;
			is_saving = Saving;
			Choice = 0;
		}
	}
}
//Check if player has opened a Box
if is_boxing
{
	oOWPlayer.char_moveable = false;
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
	
	for (var i = 0; i < Item_Count(); ++i)
		draw_text(80, 70 + i * 35, item_name[i]);
		
	for (var i = Item_Count(); i < 8; ++i)
	{
		draw_set_color(c_red);
		draw_line_width(95, 85 + i * 35, 245, 85 + i * 35, 2);
	}
	//Item Text / line drawing
	for (var i = 0; i < 10; ++i)
		if i < 8
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
		else
		{
			draw_set_color(c_red);
			draw_line_width(395, 85 + i * 35, 545, 85 + i * 35, 2);
		}
	
	
	if input_check_pressed("cancel") is_boxing = 0;
}
//Save UI
if is_saving
{
	WaitTime++;
	oOWPlayer.char_moveable = false;
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
	draw_set_font(fnt_dt_mono);
	draw_set_halign(fa_left);
	draw_text(140, 140, global.data.name);
	draw_text(295, 140, "LV" + string(global.data.lv));
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
		var input = input_check_pressed("right") - input_check_pressed("left");
		if input != 0
		{
			audio_play(snd_menu_switch);
			Choice = Posmod(Choice + input, 2);
		}
		draw_sprite_ext(sprSoul, 0, 151 + Choice * 180, 255, 1, 1, 90, c_red, abs(dsin(global.timer)) + 0.3);
		draw_text(170, 240, "Save");
		draw_text(350, 240, "Return");
		input = input_check_pressed("confirm")
		if input and WaitTime > 5
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
				Choice = 0;
			}
		}
	}
	if Saved == 2
	{
		if input_check_pressed("confirm") and WaitTime
		{
			Choice = 0;
			is_saving = false;
		}
	}
}