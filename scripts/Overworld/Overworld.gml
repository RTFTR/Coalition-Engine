///@desc Creates a dialog box in the Overworld, line height may get weird if you used sprite, that is a scribble issue
///@param {string} text			The text in the box
///@param {string} font			The font of the text (Default is dt_mono)
///@param {asset.GMSound}  char_sound	The sound of the text (Default snd_txt_typer)
///@param {real}   top_bottom	Decide whether the box is up or down (Default up)
///@param {string} sprite	The sprite of the talking character, use the format of [sprite,index (default 0),image_speed (default scribble default)]
function OW_Dialog(text, font = "fnt_dt_mono", char_sound = snd_txtTyper, top_bottom = 0, sprite = "")
{
	if sprite != "" sprite += " ";
	with oOWController
	{
		dialog_option = false;
		dialog_font = font;
		dialog_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(char_sound, 1, 1," ^!.?,:/\\|*")
		
		var dialog_width = 580,
			dialog_height = 150;
		text_writer = scribble(sprite + "* " + text)
			.scale_to_box(dialog_width - 20, dialog_height - 20)
		if text_writer.get_page() != 0 text_writer.page(0);
		
		dialog_is_down = top_bottom;
		dialog_exists = true;
	}
}

///@desc Start an option
function Option()
{
	oOWController.dialog_exists = true;
	oOWController.dialog_option = true;
}

///@desc Sets the name of the options
///@param {string} question				The question in the box
///@param {array} text					The text in the box (array of strings)
///@param {array} event					The event after selecting said option (array of functions)
///@param {string} font					The font of the text (Default is dt_mono)
///@param {asset.GMSound}  char_sound	The sound of the text (Default snd_txt_typer)
///@param {real}   top_bottom			Decide whether the box is up or down (Default up)
///@param {bool} is_vertical			Whether the options are verical or not
function Dialog_BeginOption(question, option_texts, event, font = "fnt_dt_mono", char_sound = snd_txtTyper, top_bottom = 0, ver = false)
{
	with oOWController
	{
		dialog_font = font;
		dialog_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(char_sound, 1, 1," ^!.?,:/\\|*")
		
		var dialog_width = 580,
			dialog_height = 150;
		text_writer = scribble("* " + question)
			.scale_to_box(dialog_width - 20, dialog_height - 20)
		if text_writer.get_page() != 0 text_writer.page(0);
		
		option_name = option_texts;
		option_length[0] = 25;
		var i = 0, text = "[c_white][fa_left][fa_middle]", spacing = (ver ? "\n" : "    "), len = 25;
		repeat(array_length(option_name))
		{
			text += option_name[i] + spacing;
			len += string_width(option_name[i] + spacing) * 1.8;
			option_length[i + 1] = len;
			i++;
		}
		option_amount = i;
		option_typist = scribble_typist()
						.in(0.5, 0.1)
		option_text = scribble(text)
						.starting_format(font, c_white)
		option_event = event;
		option_buffer = 20;
		option = 0;
		dialog_is_down = top_bottom;
		dialog_exists = true;
		dialog_option = true;
	}
}

/**
	@description Checks whether an object position is colliding with a tile (Rectangle collision)
	@param {real} x The object x
	@param {real} y The object y
	@param {string} layer The tile layer name
	@return {bool}
*/
function tile_meeting(_x, _y, _layer) {
	var _tm = layer_tilemap_get_id(_layer),
		_x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));

	for (var __x = _x1; __x <= _x2; __x++) {
		for (var __y = _y1; __y <= _y2; __y++) {
			if (tile_get_index(tilemap_get(_tm, __x, __y))) {
					return true;
			}
		}
	}

	return false;
}

/**
	@description Checks whether an object position is colliding with a tile (Precise collision)
	@param {real} x The object x
	@param {real} y The object y
	@param {string} layer The tile layer name
	@return {bool}
*/
function tile_meeting_precise(_x, _y, _layer) {
	var _tm = layer_tilemap_get_id(_layer),
		_checker = oGlobal;
		//Get real object reusing

	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));

	for (var __x = _x1; __x <= _x2; __x++) {
	 for (var __y = _y1; __y <= _y2; __y++) {
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