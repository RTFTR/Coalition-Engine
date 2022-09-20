function OW_Dialog(text, font = "font_dt_mono", char_sound = snd_txtTyper, top_bottom = 0)
{
	with(obj_overworld_controller)
	{
		dialog_font = font;
		dialog_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(char_sound, 1, 1," ^!.?,:/\\|*")
		
		text_writer = scribble("* " + text);
		if text_writer.get_page() != 0 text_writer.page(0);
		
		dialog_is_down = top_bottom;
		is_dialog = true;
	}
}
