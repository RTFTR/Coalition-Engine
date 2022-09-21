if is_dialog
{
	obj_player.char_moveable = false;
	var dialog_box_x = camera_get_view_x(view_camera[0]) + 30 / global.camera_scale_x;
	var dialog_box_y = (dialog_is_down ? 320 : 10) + camera_get_view_y(view_camera[0]);
	var dialog_width = 580 / global.camera_scale_x;
	var dialog_height = 150 / global.camera_scale_y;
	var dialog_box_frame = 3;
	draw_set_color(c_white);
	draw_rectangle(dialog_box_x, dialog_box_y, dialog_box_x + dialog_width, dialog_box_y + dialog_height, false);
	draw_set_color(c_black);
	draw_rectangle(dialog_box_x + dialog_box_frame, dialog_box_y + dialog_box_frame, dialog_box_x + dialog_width - dialog_box_frame, dialog_box_y + dialog_height - dialog_box_frame, false);

	text_writer.starting_format(dialog_font,c_white)
	text_writer.draw(dialog_box_x + 10, dialog_box_y + 10, dialog_typist)
		
		
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
