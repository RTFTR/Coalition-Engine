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

///@desc idk but it's for board so don't touch i guess
function point_xy(p_x, p_y)
{
	var angle = image_angle;
	
	point_x = ((p_x - x) * dcos(-angle)) - ((p_y - y) * dsin(-angle)) + x;
	point_y = ((p_y - y) * dcos(-angle)) + ((p_x - x) * dsin(-angle)) + y;
}

///@desc Returns the lengthdir_x/y values in a Vector2
function lengthdir_xy(length, dir) constructor
{
	return new Vector2(lengthdir_x(length, dir), lengthdir_y(length, dir));
}

///@desc Returns the summation of an array from a to b
///@param {array} array		The name of the array
///@param {real}  begin		The slot to begin
///@param {real}  end		The slot to end
function Sigma(arr, n, k)
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
			exit;
		}
	}
	return false;
}

function Vector2(vec2_x, vec2_y) constructor
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
}


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

function Screenshot(filename = "") {
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

///@desc Loads the text from an external text file
///@param {string} FileName	The file name of the txt file, must include .txt at the end
function LoadTextFromFile(filename)
{
	var file, DialogText, TurnNumber, current, n;
	file = file_text_open_read("./Texts/" + filename);
	current = object_get_name(object_get_parent(object_index));
	switch current
	{
		case "oEnemyParent":
			n = array_length(turn_time);
		break
		case "oBattleController":
			n = array_length(global.item);
		break
	}
	for (var i = 0; i < n; ++i;)
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
	}
	file_text_close(file);
}

///@desc Converts the values to respective keys
///@param {real} Value The to convert
function ConvertRealToKey(val)
{
	//This is so cringe, it converts vk_* (real) to string by a massive switch statement
	if is_string(val)
	{
		return val;
		exit;
	}
	//if is_real(val)
	{
		switch val
		{
			case vk_add:
				return "+";
			break
			case vk_subtract:
				return "-";
			break
			case vk_multiply:
				return "*";
			break
			case vk_divide:
				return "/";
			break
			case vk_alt:
			case vk_lalt:
			case vk_ralt:
				return "Alt";
			break
			case vk_backspace:
				return "BkSp";
			break
			case vk_printscreen:
				return "Prnt Scrn";
			break
			case vk_decimal:
				return ".";
			break
			case vk_delete:
				return "Del";
			break
			case vk_escape:
				exit
			 break
			 case vk_home:
				return "Home"
			break
			case vk_end:
				return "End";
			break
			case vk_pageup:
				return "Page Up";
			break
			case vk_pagedown:
				return "Page Down";
			break
			case vk_insert:
				return "Insert";
			break
			case vk_pause:
				return "Pause";
			break
			case vk_tab:
				return "Tab";
			break
			case vk_f2:
				return "F2";
			break
			case vk_f3:
				return "F3";
			break
			case vk_f4:
				return "F4";
			break
			case vk_f5:
				return "F5";
			break
			case vk_f6:
				return "F6";
			break
			case vk_f7:
				return "F7";
			break
			case vk_f8:
				return "F8";
			break
			case vk_f9:
				return "F9";
			break
			case vk_f10:
				return "F10";
			break
			case vk_f11:
				return "F11";
			break
			case vk_f12:
				return "F12";
			break
			case vk_control:
			case vk_lcontrol:
			case vk_rcontrol:
				return "Ctrl";
			break
			case vk_shift:
			case vk_lshift:
			case vk_rshift:
				return "Shift";
			break
			case vk_enter:
				return "Enter";
			break
			case vk_up:
				return "Up";
			break
			case vk_down:
				return "Down";
			break
			case vk_left:
				return "Left";
			break
			case vk_right:
				return "Right";
			break
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


function tips()
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