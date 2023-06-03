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
		dialog_exists = true;
	}
}

///@desc INCOMPLETE, DON'T USE
///@param {real} Amount		The cmount of options
function Option(amount)
{
	oOWController.dialog_option = true;
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
		var i = 0, text = "", temp = "* "
		repeat(array_length(option_name))
		{
			text += temp + option_name[i];
			text += (ver ? "\n" : "    ");
			option_length[i] = string_width("* " + option_name[i]) / oGlobal.camera_scale_x;
			i++;
		}
		option_text = scribble(text)
		option = 0;
	}
}

///@description Checks whether an object position is colliding with a tile (Rectangle collision)
///@param x
///@param y
///@param layer
function tile_meeting(_x, _y, _layer) {
	var _tm = layer_tilemap_get_id(_layer);

	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));

	for (var __x = _x1; _x <= _x2; _x++) {
		for (var __y = _y1; _y <= _y2; _y++) {
			if (tile_get_index(tilemap_get(_tm, __x, __y))) {
					return true;
			}
		}
	}

	return false;
}

///@desc Checks whether an object position is colliding with a tile (Precise collision)
///@param x
///@param y
///@param layer
function tile_meeting_precise(_x, _y, _layer) {
	var _tm = layer_tilemap_get_id(_layer),
		_checker = oGlobal;
		//Get real object reusing

	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));

	for (var __x = _x1; _x <= _x2; _x++) {
	 for (var __y = _y1; _y <= _y2; _y++) {
		var _tile = tile_get_index(tilemap_get(_tm, __x, __y));
			if (_tile) {
				if (_tile == 1) return true;
			
				_checker.x = __x * tilemap_get_tile_width(_tm);
				_checker.y = __y * tilemap_get_tile_height(_tm);
				_checker.image_index = _tile;

				if (place_meeting(_x, _y, _checker)) return true;
			}
		}
	}

	return false;
}