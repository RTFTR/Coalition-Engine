///@desc Creates a dialog box in the Overworld (INCOMPLETE)
///@param {string} text			The text in the box
///@param {string} font			The font of the text (Default is dt_mono)
///@param {asset.GMSound}  char_sound	The sound of the text (Default snd_txt_typer)
///@param {real}   top_bottom	Decide whether the box is up or down (Default up)
function OW_Dialog(text, font = "fnt_dt_mono", char_sound = snd_txtTyper, top_bottom = 0)
{
	with oOWController
	{
		dialog_font = font;
		dialog_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(char_sound, 1, 1," ^!.?,:/\\|*")
		
		var dialog_width = 580,
			dialog_height = 150;
		text_writer = scribble("* " + text)
			.scale_to_box(dialog_width - 20, dialog_height - 20)
		if text_writer.get_page() != 0 text_writer.page(0);
		
		dialog_is_down = top_bottom;
		is_dialog = true;
		//scribble_typists_add_event(string_char_at(text, string_length(text)), Option)
	}
}

///@desc INCOMPLETE, DON'T USE
///@param {real} Amount		The cmount of options
function Option(amount)
{
	oOWController.is_dialog_a_option = true;
}

///@desc Sets the name of the options
///@param {bool} is_vertical	Whether the options are verical or not
///@param {string} Option	The name of the options
function Dialog_SetOptionName(ver = false)
{
	with oOWController
	{
		for(var i = 1; i < argument_count; ++i)
			option_name[i - 1] = argument[i];
		option_typist = scribble_typist()
						.in(0, 0)
		for (var i = 0, text = "", temp = "* ", n = array_length(option_name); i < n; ++i)
		{
			text += temp + option_name[i];
			text += (ver ? "\n" : "    ");
			option_length[i] = string_width("* " + option_name[i]) / oGlobal.camera_scale_x;
		}
		option_text = scribble(text)
		option = 0;
	}
}


