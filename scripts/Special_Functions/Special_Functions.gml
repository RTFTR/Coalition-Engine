/// @desc Returns a Positive Quotient of the 2 values
/// @param {real} a The number to be divided
/// @param {real} b The number to divide
/// @return {real}
function posmod(a, b)
{
	var value = a % b;
	while (value < 0 and b > 0) or (value > 0 and b < 0) 
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
///@return {struct}
function lengthdir_xy(length, dir) constructor
{
	return new Vector2(lengthdir_x(length, dir), lengthdir_y(length, dir));
}

///@desc Returns the summation of an array from a to b
///@param {array} array		The name of the array
///@param {real}  begin		The slot to begin
///@param {real}  end		The slot to end
///@return {real}
function Sigma(arr, n, k)
{
	for(var i = n, value = 0; i <= k; ++i)
		value += arr[i];
	return value;
}

///@desc Checks if the value is equal to the other given values
///@return {bool}
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

///@desc Checks whether the instance is outside the camera DETERMINED BY IT'S HITBOX
///@return {bool}
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

///@desc Takes a screenshot and saves it with given filename + current time
function Screenshot(filename = "") {
	var date = string(current_year) + "y-" + string(current_month) + "m-" + string(current_day) + "d_" +
		string(current_hour) + "h_" + string(current_minute) + "m_" + string(current_second) + "s"
	screen_save("Screenshots/" + string(filename) + date + ".png")
}

/**
	@desc Draws a rectagle with given width and color
	@param {real} x1 The x coordinate of the top left coordinate of the rectangle
	@param {real} y1 The y coordinate of the top left coordinate of the rectangle
	@param {real} x2 The x coordinate of the bottom right coordinate of the rectangle
	@param {real} y2 The y coordinate of the bottom right coordinate of the rectangle
	@param {real} width	The width of the outline of the rectangle (Default 1)
	@param {Constant.Color} color The color of the rectangle (Default white)
	@param {bool} full	Whether the rectangle is a semi-round angled rectangle or a full right-angled rectangle (Default former)
*/
function draw_rectangle_width(x1, y1, x2, y2, width = 1, color = c_white, full = false)
{
	var dis = real(full) * width / 2,
		prev_col = draw_get_color();
	draw_set_color(color);
	draw_line_width(x1 - dis, y1, x2 + dis, y1, width);
	draw_line_width(x1 - dis, y2, x2 + dis, y2, width);
	draw_line_width(x1, y1 - dis, x1, y2 + dis, width);
	draw_line_width(x2, y1 - dis, x2, y2 + dis, width);
	draw_set_color(prev_col);
}

/**
	@desc Draws a rectangle with a outline color and background color
	@param {real} x1							The x coordinate of the top left coordinate of the rectangle
	@param {real} y1							The y coordinate of the top left coordinate of the rectangle
	@param {real} x2							The x coordinate of the bottom right coordinate of the rectangle
	@param {real} y2							The y coordinate of the bottom right coordinate of the rectangle
	@param {real} width							The width of the outline of the rectangle (Default 1)
	@param {Constant.Color} outline_color		The color of the outline of the rectangle (Default white)
	@param {real} outline_alpha					The alpha of the outline (Default 1)
	@param {Constant.Color} background_color	The color of the background of the rectangle (Default black)
	@param {real} background_alpha				The alpha of the background (Default 1)
	@param {bool} full							Whether the rectangle is a semi-round angled rectangle
												or a full right-angled rectangle (Default former)
*/
function draw_rectangle_width_background(x1, y1, x2, y2, width = 1, ocolor = c_white, oalpha = 1, bcolor = c_black, balpha = 1, full = false)
{
	var al = draw_get_alpha(), col = draw_get_color();
	draw_set_alpha(balpha);
	draw_set_color(bcolor);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_alpha(oalpha);
	draw_rectangle_width(x1, y1, x2, y2, width, ocolor, full);
	draw_set_alpha(al);
	draw_set_color(col);
}

/**
	@param {string} FileName	The file name of the txt file, must include .txt at the end
	@param {real} Read_Method The method of reading the text files, default 0
	@param {string} Tag	The tag of the string to get
	@desc Loads the text from an external text file, there are 2 reading methods for now:
		  0 is by using numbers to indicate the turn number (during battle)
		  1 is by using tags to let the script read which text to load
	@return {string}
*/
function LoadTextFromFile(filename, read_method = 0, tag = "")
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
///@return {string}
function ConvertRealToKey(val)
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
///@return {Array<Asset.GMSound>}
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
///@desc Destroys all audio that were streams in the array then remove the array
///@param {Array<Asset.GMSound>} array	The array of streamed audio to destroy
function audio_destroy_stream_array(arr)
{
	var i = 0;
	repeat array_length(arr)
	{
		audio_stream_destroy(arr[i]);
		++i;
	}
	arr = -1;
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

#region functions where idk


#endregion

#region The part where things go insane (Codes are modified from Vinyl by JujuAdams)
function DistanceToEdge(_px, _py, _x0, _y0, _x1, _y1)
{
    var _dx = _x1 - _x0;
    var _dy = _y1 - _y0;
    var _lengthSqr = _dx * _dx + _dy * _dy;
        
    //Edge case where the line has length 0
    if (_lengthSqr <= 0) return point_distance(_px, _py, _x0, _y0);
        
    var _t = clamp((_dx * (_px - _x0) + (_py - _y0) * _dy) / _lengthSqr, 0, 1);
    return point_distance(_px, _py, _x0 + _t * _dx, _y0 + _t * _dy);
}

function ClosestPointOnEdge(_px, _py, _x0, _y0, _x1, _y1)
{
    static _result = {
        x: undefined,
        y: undefined,
    }
	
    var _dx = _x1 - _x0;
    var _dy = _y1 - _y0;
    var _lengthSqr = _dx * _dx + _dy * _dy;
        
    //Edge case where the line has length 0
    if (_lengthSqr <= 0)
    {
        _result.x = _x0;
        _result.y = _y0;
    }
    else
    {
        var _t = clamp((_dx * (_px - _x0) + (_py - _y0) * _dy) / _lengthSqr, 0, 1);
        _result.x = _x0 + _t * _dx;
        _result.y = _y0 + _t * _dy;
    }
        
    return [_result.x, _result.y];
}

function InsidePolygon(px, py, polygon)
{
    var inside = false;
    var n, i = 0, polyX, polyY, x1, y1, x2, y2;
    n = array_length(polygon) div 2;
    repeat n
    {
        polyX[i] = polygon[2 * i];
        polyY[i] = polygon[2 * i + 1];
		++i;
    }
    polyX[n] = polyX[0];
    polyY[n] = polyY[0];
	i = 0;
    repeat n
    {
        x1 = polyX[i];
        y1 = polyY[i];
        x2 = polyX[i + 1];
        y2 = polyY[i + 1];
 
        if ((y2 > py) != (y1 > py)) 
        {
            inside ^= (px < (x1-x2) * (py-y2) / (y1-y2) + x2);
        }       
		++i;
    }
    return inside;
}

function SnapToNearestEdge(_px, _py, _pointArray)
{
        var _x0 = undefined;
        var _y0 = undefined;
        var _x1 = _pointArray[0];
        var _y1 = _pointArray[1];
        
        var _minDist = infinity;
        var _minI    = undefined;
        
        //Find the closest line to the point
        var _i = 0;
        repeat((array_length(_pointArray) div 2) - 1)
        {
            _x0 = _x1;
            _y0 = _y1;
            _x1 = _pointArray[_i + 2];
            _y1 = _pointArray[_i + 3];
             
            var _distance = DistanceToEdge(_px, _py, _x0, _y0, _x1, _y1);
            if (_distance < _minDist)
            {
                _minDist = _distance;
                _minI    = _i;
            }
            
            _i += 2;
        }
        
        if (_minI != undefined)
        {
            //Get the point on the line closest to the listener
            var _point = ClosestPointOnEdge(_px, _py, _pointArray[_minI], _pointArray[_minI+1], _pointArray[_minI+2], _pointArray[_minI+3]);
			var _angle = point_direction(_pointArray[_minI], _pointArray[_minI + 1], _pointArray[_minI + 2], _pointArray[_minI + 3]);
			_point[2] = _angle;
			
			var _dX = _point[0] - oSoul.x;
	        var _dY = _point[1] - oSoul.y;
        
	        var _length = sqrt(_dX*_dX + _dY*_dY);
	        if (_length > 8)
	        {
	            var _factor = 8/_length;
	            _point[0] = _factor*_dX + oSoul.x;
	            _point[1] = _factor*_dY + oSoul.y;
	        }
	        else
	        {
	            _point[0] = _point[0];
	            _point[1] = _point[1];
	        }
			
			return _point;
		}
}
/**
	* Clamps the soul inside the board
*/
function BoardClampSoul()
{
	for (var i = -8; i < 8; ++i) {
		for (var ii = -8; ii < 8; ++ii) {
			if !InsidePolygon(oSoul.x + i, oSoul.y + ii, oBoard.Vertex)
			{
				var _ = SnapToNearestEdge(oSoul.x + i, oSoul.y + ii, oBoard.Vertex);
				oSoul.x = _[0] - i;
				oSoul.y = _[1] - ii;
				exit
			}
		}
	}
}
#endregion