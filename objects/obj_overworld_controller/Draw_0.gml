if is_dialog
{
	obj_player.char_moveable = false;
	var dialog_box_y = (dialog_is_down ? 320 : 10);
	draw_set_color(c_white);
	draw_rectangle(30, dialog_box_y, 610, dialog_box_y + 150, false);
	draw_set_color(c_black);
	draw_rectangle(35, dialog_box_y + 5, 605, dialog_box_y + 145, false);

	text_writer.starting_format(dialog_font,c_white)
	text_writer.draw(52, dialog_box_y + 15, dialog_typist)
		
		
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
