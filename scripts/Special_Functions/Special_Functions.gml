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

/**
	@param {string} FileName	The file name of the txt file, must include .txt at the end
	@param {real} Read_Method The method of reading the text files, default 0
	@param {string} Tag	The tag of the string to get
	@desc Loads the text from an external text file, there are 2 reading methods for now:
		  0 is by using numbers to indicate the turn number (during battle)
		  1 is by using tags to let the script read which text to load
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

#region functions where idk what to do with them


#endregion

#region The part where things go insane
/**
	* Clamps the soul inside the board (Codes are modified from Vinyl by JujuAdams)
*/
function BoardClampSoul() constructor
{
	static __StateReset = function()
    {   
        __reference = undefined;
        
        __mode = 0; //0 = __Point, 1 = __Circle, 2 = __Rectangle
        
        __actualX = 0;
        __actualY = 0;
        
        __x      = 0;
        __y      = 0;
        __radius = 0;
        
        __left   = 0;
        __top    = 0;
        __right  = 0;
        __bottom = 0;
        
        __pointArray = undefined;
    }
	static __PositionSet = function(_x, _y)
    {
        var _dx = _x - __x;
        var _dy = _y - __y;
        
        __x       =  _x;
        __y       =  _y;
        __left   += _dx;
        __top    += _dy;
        __right  += _dx;
        __bottom += _dy;
        
        //Immediately update
        if ((_dx != 0) || (_dy != 0)) __ManagePosition();
    }
    
    static __PositionGet = function()
    {
        static _result = {
            x: undefined,
            y: undefined,
        };
        
        _result.x = __x;
        _result.y = __y;
        
        return _result;
    }
    
    static __Point = function(_x, _y)
    {
        __mode = 0;
        
        __x      = _x;
        __y      = _y;
        __radius = 0;
        
        __left   = _x - __radius;
        __top    = _y - __radius;
        __right  = _x + __radius;
        __bottom = _y + __radius;
        
        __pointArray = undefined;
        
        __ManagePosition();
    }
    
    static __Circle = function(_x, _y, _radius)
    {
        __mode = 1;
        
        __x      = _x;
        __y      = _y;
        __radius = _radius;
        
        __left   = _x - _radius;
        __top    = _y - _radius;
        __right  = _x + _radius;
        __bottom = _y + _radius;
        
        __pointArray = undefined;
        
        __ManagePosition();
    }
    
    static __Rectangle = function(_left, _top, _right, _bottom)
    {
        __mode = 2;
        
        __left   = _left;
        __top    = _top;
        __right  = _right;
        __bottom = _bottom;
        
        __pointArray = undefined;
        
        __x      = 0.5*(__left + __right);
        __y      = 0.5*(__top + __bottom);
        __radius = 0;
        
        __ManagePosition();
    }
    
    static __Polyline = function(_radius, _pointArray, _x = 0, _y = 0)
    {
        __mode = 3;
        
        var _length = array_length(_pointArray);
        if ((_length mod 2) != 0) __VinylError("Polyline-type emitters should have an even number of elements, structured as coordinate pairs (length=", _length, ")");
        if (_length < 4) __VinylError("Polyline-type emitters should have at least 2 coordinate pairs (length=", _length, ")");
        
        __radius     = _radius;
        __pointArray = _pointArray;
        __x          = _x;
        __y          = _y;
        
        __BuildBoundsFromPointArray();
        
        __ManagePosition();
    }
    
    static __Polygon = function(_radius, _pointArray, _x = 0, _y = 0)
    {
        __mode = 4;
        
        var _length = array_length(_pointArray);
        if ((_length mod 2) != 0) __VinylError("Polygon-type emitters should have an even number of elements, structured as coordinate pairs (length=", _length, ")");
        if (_length < 6) __VinylError("Polygon-type emitters should have at least 3 coordinate pairs (length=", _length, ")");
        
        //Ensure the polygon is closed
        if ((_pointArray[0] != _pointArray[_length-2]) || (_pointArray[1] != _pointArray[_length-1]))
        {
            array_push(_pointArray, _pointArray[0], _pointArray[1]);
        }
        
        __radius     = _radius;
        __pointArray = _pointArray;
        __x          = _x;
        __y          = _y;
        
        __BuildBoundsFromPointArray();
        
        __ManagePosition();
    }
    
    static __BuildBoundsFromPointArray = function()
    {
        __left   =  infinity;
        __top    =  infinity;
        __right  = -infinity;
        __bottom = -infinity;
        
        var _i = 0;
        repeat(array_length(__pointArray) div 2)
        {
            var _x = __pointArray[_i  ];
            var _y = __pointArray[_i+1];
            
            __left   = min(_x, __left  );
            __top    = min(_y, __top   );
            __right  = max(_x, __right );
            __bottom = max(_y, __bottom);
            
            _i += 2;
        }
        
        __x = 0.5*(__left + __right);
        __y = 0.5*(__top + __bottom);
    }
	static __ManagePosition = function()
    {
        if (__mode == 0) //Point
        {
            __actualX = __x;
            __actualY = __y;
        }
        else if (__mode == 1) //Circle
        {
            __ManageFromCircle(__x, __y);
        }
        else if (__mode == 2) //Rectangle
        {
            __actualX = clamp(oSoul.x, __left, __right );
            __actualY = clamp(oSoul.y, __top,  __bottom);
        }
        else if (__mode == 3) //Polyline
        {
            __ManageFromEdges();
        }
        else if (__mode == 4) //Polygon
        {
            var _px = oSoul.x - __x;
            var _py = oSoul.y - __y;
            
            var _pointArray = __pointArray;
            
            var _x0 = undefined;
            var _y0 = undefined;
            var _x1 = _pointArray[0];
            var _y1 = _pointArray[1];
            
            var _inside = false;
            
            //Find the closest line to the point
            var _i = 2;
            repeat((array_length(_pointArray) div 2)-1)
            {
                _x0 = _x1;
                _y0 = _y1;
                _x1 = _pointArray[_i  ];
                _y1 = _pointArray[_i+1];
                
                if ((_y1 > _py) != (_y0 > _py))
                {
                    _inside ^= (_px < _x1 + ((_x0 - _x1)*(_py - _y1) / (_y0 - _y1)));
                }
                
                _i += 2;
            }
            
            if (_inside)
            {
                //If the listener is inside the polygon, set our emitter position to the listener
                __actualX = _px + __x;
                __actualY = _py + __y;
            }
            else
            {
                //Otherwise find the nearest edge
                __ManageFromEdges();
            }
        }
		oSoul.x = __actualX;
		oSoul.y = __actualY;
    }
    
    static __ManageFromEdges = function()
    {
        var _px = oSoul.x - __x;
        var _py = oSoul.y - __y;
        
        var _pointArray = __pointArray;
        
        var _x0 = undefined;
        var _y0 = undefined;
        var _x1 = _pointArray[0];
        var _y1 = _pointArray[1];
        
        var _minDist = infinity;
        var _minI    = undefined;
        
        //Find the closest line to the point
        var _i = 0;
        repeat((array_length(_pointArray) div 2)-1)
        {
            _x0 = _x1;
            _y0 = _y1;
            _x1 = _pointArray[_i+2];
            _y1 = _pointArray[_i+3];
             
            var _distance = __DistanceToEdge(_px, _py, _x0, _y0, _x1, _y1);
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
            var _point = __ClosestPointOnEdge(_px, _py, _pointArray[_minI], _pointArray[_minI+1], _pointArray[_minI+2], _pointArray[_minI+3]);
            
            //We then use the same maths as the Circle emitter to create a circular area around the polyline
            __ManageFromCircle(_point.x + __x, _point.y + __y);
        }
    }
    
    static __ManageFromCircle = function(_circleX, _circleY)
    {
        var _dX = oSoul.x - _circleX;
        var _dY = oSoul.y - _circleY;
        
        var _length = sqrt(_dX*_dX + _dY*_dY);
        if (_length > __radius)
        {
            var _factor = __radius/_length;
            __actualX = _factor*_dX + _circleX;
            __actualY = _factor*_dY + _circleY;
        }
        else
        {
            __actualX = oSoul.x;
            __actualY = oSoul.y;
        }
    }
    
    static __DistanceToEdge = function(_px, _py, _x0, _y0, _x1, _y1)
    {
        var _dx = _x1 - _x0;
        var _dy = _y1 - _y0;
        var _lengthSqr = _dx*_dx + _dy*_dy;
        
        //Edge case where the line has length 0
        if (_lengthSqr <= 0) return point_distance(_px, _py, _x0, _y0);
        
        var _t = clamp((_dx*(_px - _x0) + (_py - _y0)*_dy) / _lengthSqr, 0, 1);
        return point_distance(_px, _py, _x0 + _t*_dx, _y0 + _t*_dy);
    }
    
    static __ClosestPointOnEdge = function(_px, _py, _x0, _y0, _x1, _y1)
    {
        static _result = {
            x: undefined,
            y: undefined,
        }
        
        var _dx = _x1 - _x0;
        var _dy = _y1 - _y0;
        var _lengthSqr = _dx*_dx + _dy*_dy;
        
        //Edge case where the line has length 0
        if (_lengthSqr <= 0)
        {
            _result.x = _x0;
            _result.y = _y0;
        }
        else
        {
            var _t = clamp((_dx*(_px - _x0) + (_py - _y0)*_dy) / _lengthSqr, 0, 1);
            _result.x = _x0 + _t*_dx;
            _result.y = _y0 + _t*_dy;
        }
        
        return _result;
    }
	static __DebugDraw = function()
    {
        draw_line(__x-7, __y-7, __x+7, __y+7);
        draw_line(__x+7, __y-7, __x-7, __y+7);
        draw_rectangle(__actualX-3, __actualY-3, __actualX+3, __actualY+3, true);
        
        if (__mode == 1) //Circle
        {
            draw_circle(__x, __y, __radius, true);
        }
        else if (__mode == 2) //Rectangle
        {
            draw_rectangle(__left, __top, __right, __bottom, true);
        }
        else if ((__mode == 3) || (__mode == 4)) //Polyline or Polygon
        {
            draw_primitive_begin(pr_linestrip);
            
            var _i = 0;
            repeat(array_length(__pointArray) div 2)
            {
                draw_vertex(__pointArray[_i] + __x, __pointArray[_i+1] + __y);
                _i += 2;
            }
            
            draw_primitive_end();
            
            if (__radius > 0) draw_circle(__actualX, __actualY, __radius, true);
        }
    }
}
#endregion