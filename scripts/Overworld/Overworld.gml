///@desc Creates a dialog box in the Overworld
///@param text			The text in the box
///@param font			The font of the text (Default is dt_mono)
///@param dhar_sound	The sound of the text (Default snd_txt_typer)
///@param top_bottom	Decide whether the box is up or down (Default Up)

function OW_Dialog(text, font = "font_dt_mono", char_sound = snd_txtTyper, top_bottom = 0)
{
	with(obj_overworld_controller)
	{
		dialog_font = font;
		dialog_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(char_sound, 1, 1," ^!.?,:/\\|*")
		
		var dialog_width = 580 / global.camera_scale_x;
		var dialog_height = 150 / global.camera_scale_y;
		text_writer = scribble("* " + text)
			.transform(1 / global.camera_scale_x, 1 / global.camera_scale_y, 0)
			.scale_to_box(dialog_width - 10, dialog_height - 10)
		if text_writer.get_page() != 0 text_writer.page(0);
		
		dialog_is_down = top_bottom;
		is_dialog = true;
	}
}


