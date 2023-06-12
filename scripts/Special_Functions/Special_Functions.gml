/// @desc Returns a Positive Quotient of the 2 values
/// @param {real} a The number to be divided
/// @param {real} b The number to divide
/// @return {real}
function posmod(a,b)
{
	var value = a % b;
	if (value < 0 and b > 0) or (value > 0 and b < 0) 
		value += b;
	return value;
}

///@desc Calculating the legnthdir_xy position of the points
function point_xy(p_x, p_y)
{
	var angle = image_angle;
	
	point_x = ((p_x - x) * dcos(-angle)) - ((p_y - y) * dsin(-angle)) + x;
	point_y = ((p_y - y) * dcos(-angle)) + ((p_x - x) * dsin(-angle)) + y;
}

///@desc Returns the lengthdir_x/y values in a Vector2 (stupidly useless)
function lengthdir_xy(length, dir) constructor
{
	return new Vector2(lengthdir_x(length, dir), lengthdir_y(length, dir));
}

///@desc Returns the summation of an array from a to b
///@param {array} array		The name of the array
///@param {real}  begin		The slot to begin
///@param {real}  end		The slot to end
function sigma(arr, n, k)
{
	for(var i = n, value = 0; i <= k; ++i)
		value += arr[i];
	return value;
}

///@desc Checks if the value is equal to the other given values
function is_val()
{
	for (var i = 1; i < argument_count; ++i)
	{
		if argument[0] == argument[i]
		{
			return true;
		}
	}
	return false;
}

#region Replaced in TurboGML / _tgm_core
/*function Vector2(vec2_x, vec2_y) constructor
{
	x = vec2_x;
	y = vec2_y;
}

function Vector3(vec3_x, vec3_y, vec3_z) constructor
{
	x = vec3_x;
	y = vec3_y;
	z = vec3_z;
	xy = 
	{
		x : vec3_x,
		y : vec3_y
	};
	
	yz = 
	{
		y : vec3_y,
		z : vec3_z
	};
	
	xz = 
	{
		x : vec3_x,
		z : vec3_z
	};
}*/
#endregion


///@desc Checks whether the instance is outside the camera DETERMINED BY IT'S HITBOX
function check_outside(){
	var cam = view_camera[0],
		view_x = camera_get_view_x(cam),
		view_y = camera_get_view_y(cam),
		view_w = camera_get_view_width(cam),
		view_h = camera_get_view_height(cam);
	
	return !rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, view_x, view_y, view_x + view_w, view_y + view_h) 
	and (
			(x < -sprite_width) or 
			(x > (room_width + sprite_width)) or
			(y > (room_height + sprite_height)) or
			(y < (-sprite_height))
		)
}

function screenshot(filename = "") {
	var date = string(current_year) + "y-" + string(current_month) + "m-" + string(current_day) + "d_" +
		string(current_hour) + "h_" + string(current_minute) + "m_" + string(current_second) + "s"
	screen_save("Screenshots/" + string(filename) + date + ".png")
}

///@desc Draws a rectagle with given width
function draw_rectangle_width(x1, y1, x2, y2, width = 1, color = c_white)
{
	var prev_col = draw_get_color();
	draw_set_color(color);
	draw_line_width(x1, y1, x2, y1, width);
	draw_line_width(x1, y2, x2, y2, width);
	draw_line_width(x1, y1, x1, y2, width);
	draw_line_width(x2, y1, x2, y2, width);
	draw_set_color(prev_col);
}

/**
	@param {string} FileName	The file name of the txt file, must include .txt at the end
	@param {real} Read_Method The method of reading the text files, default 0
	@param {string} Tag	The tag of the string to get
	@desc Loads the text from an external text file, there are 2 reading methods for now:
		  0 is by using numbers to indicate the turn number (during battle)
		  1 is by using tags to let the script read which text to load
*/
function load_text_from_file(filename, read_method = 0, tag = "")
{
	var file, DialogText, TurnNumber, current, n, i = 0;
	file = file_text_open_read("./Texts/" + filename);
	current = object_get_name(object_get_parent(object_index));
	switch read_method
	{
		case 0:
			switch current
			{
				case "oEnemyParent":
					n = array_length(turn_time);
				break
				case "oBattleController":
					n = array_length(global.item);
				break
			}
			repeat(n)
			{
				switch current
				{
					case "oEnemyParent":
						TurnNumber = file_text_read_real(file);
						file_text_readln(file);
						DialogText = file_text_read_string(file);
						file_text_readln(file);
						Battle_EnemyDialog(TurnNumber, DialogText);
					break
				}
				i++;
			}
		break
		case 1:
			var str;
			while (!file_text_eof(file))
			{
				str = file_text_read_string(file);
				if str == tag
				{
					file_text_readln(file);
					var rtn_str = file_text_read_string(file);
					file_text_close(file);
					return rtn_str;
				}
				file_text_readln(file);
			}
			file_text_close(file);
			return "";
		break
	}
	file_text_close(file);
}

///@desc Converts the values to respective keys
///@param {real} Value The to convert
function convert_realtokey(val)
{
	//This is so cringe, it converts vk_* (real) to string by a massive switch statement
	if is_string(val)
	{
		return val;
	}
	//if is_real(val)
	{
		switch val
		{
			case vk_add:
				return "+";
			case vk_subtract:
				return "-";
			case vk_multiply:
				return "*";
			case vk_divide:
				return "/";
			case vk_alt:
			case vk_lalt:
			case vk_ralt:
				return "Alt";
			case vk_backspace:
				return "BkSp";
			case vk_printscreen:
				return "Prnt Scrn";
			case vk_decimal:
				return ".";
			case vk_delete:
				return "Del";
			case vk_escape:
				exit
			 case vk_home:
				return "Home"
			case vk_end:
				return "End";
			case vk_pageup:
				return "Page Up";
			case vk_pagedown:
				return "Page Down";
			case vk_insert:
				return "Insert";
			case vk_pause:
				return "Pause";
			case vk_tab:
				return "Tab";
			case vk_f2:
				return "F2";
			case vk_f3:
				return "F3";
			case vk_f4:
				return "F4";
			case vk_f5:
				return "F5";
			case vk_f6:
				return "F6";
			case vk_f7:
				return "F7";
			case vk_f8:
				return "F8";
			case vk_f9:
				return "F9";
			case vk_f10:
				return "F10";
			case vk_f11:
				return "F11";
			case vk_f12:
				return "F12";
			case vk_control:
			case vk_lcontrol:
			case vk_rcontrol:
				return "Ctrl";
			case vk_shift:
			case vk_lshift:
			case vk_rshift:
				return "Shift";
			case vk_enter:
				return "Enter";
			case vk_up:
				return "Up";
			case vk_down:
				return "Down";
			case vk_left:
				return "Left";
			case vk_right:
				return "Right";
		}
	}
	var Alphabet =
	["A", "B", "C", "D", "E", "F", "G", "H", "I",
	"J", "K", "L", "M", "N", "O", "P", "Q", "R",
	"S", "T" ,"U", "V", "W", "X", "Y", "Z", "1",
	"2", "3", "4", "5", "6", "7", "8", "9", "0"]
	for(var i = 0; i < 36; i++)
	{
		if val == ord(Alphabet[i])
			return Alphabet[i];
		//Cringe
	}
}

///@desc Creates an array of audios from audio_create_stream(), arguments are all strings, no folder name and file format needed
function audio_create_stream_array()
{
	for(var i = 0, arr = []; i < argument_count; ++i)
	{
		//Only pushes the array if file exists
		var text = "Music/" + string(argument[i]) + ".ogg";
		array_push(arr, audio_create_stream(text));
	}
	return arr;
}


function random_tip()
{
	var tips = [
					"Reasons for engine: There are none",
					"O-oooooooooo AAAAE-A-A-I-A-U-",
					"Never gonna-",
					"bread.",
					"Tip: Dodge the attacks to prevent dying.",
					"Be proud of your death counts....\noh wait you can't view it.",
					"Eden: Casually puts rng.\nPlayers: Our opinion is ignored.",
					"Carbine: Oh hey Ednes! How's your day?",
					"Moroz: ._.",
					"QSV: This game has RNG, trash game.",
					"Arceh: eden there's bug.",
					"Eden: I'm gonna make kuky fight to bully him.\nMoroz: Yes.",
					"Daunted: Casually clips outside of the box.",
					"TK: Inplements green soul and replay mechanics becase RR and Touhou.",
					"This game sucks, needs loading time.",
					"snes: Casually spams the N-word in chat",
					"Panthervention: Rhythm Recall is bad\nTK: no u\nEpic staredown contest intensifies",
					
				],
	amt = array_length(tips);
	return tips[irandom(amt - 1)];
}

#region From Alice
/// @function file_read_all_text(filename)
/// @description Reads entire content of a given file as a string, or returns undefined if the file doesn't exist.
/// @param {string} filename		The path of the file to read the content of.
function file_read_all_text(_filename) {
	if (!file_exists(_filename)) {
		return undefined;
	}
	
	var _buffer = buffer_load(_filename);
	var _result = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	return _result;
}

/// @function file_write_all_text(filename,content)
/// @description Creates or overwrites a given file with the given string content.
/// @param {string} filename		The path of the file to create/overwrite.
/// @param {string} content			The content to create/overwrite the file with.
function file_write_all_text(_filename, _content) {
	var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
	buffer_write(_buffer, buffer_string, _content);
	buffer_save(_buffer, _filename);
	buffer_delete(_buffer);
}

/// @func string_split_lines(str)
/// @desc Splits the string by newline characters/sequences (CRLF, CR, LF).
/// @arg {String} str			   The string to split.
/// @arg {Bool} remove_empty		Determines whether the final result should filter out empty strings or not.
/// @arg {Real} max_splits		  The maximum number of splits to make.
/// @returns {Array<String>}
function string_split_lines(_str, _remove_empty = false, _max_splits = undefined) {
	static separators = ["\r\n", "\r", "\n"];
	
	if (!is_undefined(_max_splits))
		return string_split_ext(_str, separators, _remove_empty, _max_splits);
	else
		return string_split_ext(_str, separators, _remove_empty);
}

/// @function json_load(filename)
/// @description Loads a given JSON file into a GML value (struct/array/string/real).
/// @param {string} filename		The path of the JSON file to load.
function json_load(_filename) {
	var _json_content = file_read_all_text(_filename);
	if (is_undefined(_json_content))
		return undefined;
	
	try {
		return json_parse(_json_content);
	} catch (_) {
		// if the file content isn't a valid JSON, prevent crash and return undefined instead
		return undefined;
	}
}

/// @function json_save(filename,value)
/// @description Saves a given GML value (struct/array/string/real) into a JSON file.
/// @param {string} filename		The path of the JSON file to save.
/// @param {any} value				The value to save as a JSON file.
function json_save(_filename, _value) {
	var _json_content = json_stringify(_value);
	file_write_all_text(_filename, _json_content);
}
#endregion