if is_dialog
{
	obj_player.char_moveable = false;
	var dialog_box_x = 30
	var dialog_box_y = (dialog_is_down ? 320 : 10);
	var dialog_width = 580;
	var dialog_height = 150;
	var dialog_box_frame = 5;
	draw_set_color(c_white);
	draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width,
					dialog_box_y + dialog_height, false);
	draw_set_color(c_black);
	draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame,
					dialog_box_x + dialog_width - dialog_box_frame,
					dialog_box_y + dialog_height - dialog_box_frame, false);

	text_writer.starting_format(dialog_font,c_white)
	text_writer.draw(dialog_box_x + 20, dialog_box_y + 15, dialog_typist)
		
		
	if input_check_pressed("cancel")
	{
		text_writer.page(text_writer.get_page_count() - 1);
		dialog_typist.skip();
	}
	if dialog_typist.get_state() == 1 and text_writer.get_page() < (text_writer.get_page_count() - 1)
		text_writer.page(text_writer.get_page() + 1)
	if dialog_typist.get_state() == 1
	{
		if input_check_pressed("confirm"){ is_dialog = false; obj_player.char_moveable = true;}
	}
}
if is_boxing
{
	obj_player.char_moveable = false;
	var dialog_box_x = 20
	var dialog_box_y = 20;
	var dialog_width = 600;
	var dialog_height = 440;
	var dialog_box_frame = 5;
	draw_set_color(c_white);
	draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width,
					dialog_box_y + dialog_height, false);
	draw_set_color(c_black);
	draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame,
					dialog_box_x + dialog_width - dialog_box_frame,
					dialog_box_y + dialog_height - dialog_box_frame, false);
	
	draw_set_color(c_white);
	draw_line_width(320, 90, 320, 390, 5);
	draw_set_font(font_dt_sans);
	draw_set_halign(fa_center);
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