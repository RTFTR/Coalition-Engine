//Macro Declaration
enum LineProperties
{
	NONE = 0,
	TRAIL = 1
}
enum LineEndProperty
{
	NONE = 0,
	FADEOUT = 1
}
enum LineLayer
{
	BELOW = 0,
	ABOVE = 1
}
enum SetLineProperty
{
	Speed = 0,
	Direction = 1,
	Width = 2,
	Alpha = 3,
	AlphaFade = 4,
	Color = 5,
	Properties = 6,
	FadeProperties = 7,
	Duration = 8,
	Layer = 9
}

///@desc Checks whether the lines system exists, if not then create one
function CheckLineSystemExists()
{
	if !instance_exists(oLineSystem) instance_create_depth(0, 0, 0, oLineSystem);
}

///@desc Loads the Line System
function LineSystem_Load()
{
	//Global line library
	global.Line = {};
	global.Line.Lines				= 0;
	global.Line.LinePoints			= ds_list_create();
	global.Line.LineWidth			= ds_list_create();
	global.Line.LineSpeed			= ds_list_create();
	global.Line.LineDirection		= ds_list_create();
	global.Line.LineAlpha			= ds_list_create();
	global.Line.LineAlphaFade		= ds_list_create();
	global.Line.LineColor			= ds_list_create();
	global.Line.LineProperties		= ds_list_create();
	global.Line.LineFadeProperties	= ds_list_create();
	global.Line.LineDuration		= ds_list_create();
	global.Line.LineLayer			= ds_list_create();
	
	//Local
	Timer = [];
	FadingLines = 0;
	FadingPosition = [];
	FadingAlpha = [];
	FadingAlphaFade = [];
	FadingLineParentIndex = [];
	
	//Show that the object is created
	show_debug_message("Line System is created");
}

//@desc Cleans up the Line SYstem
function LineSystem_CleanUp()
{
	ds_list_destroy(global.Line.LinePoints);
	ds_list_destroy(global.Line.LineWidth);
	ds_list_destroy(global.Line.LineSpeed);
	ds_list_destroy(global.Line.LineDirection);
	ds_list_destroy(global.Line.LineAlpha);
	ds_list_destroy(global.Line.LineAlphaFade);
	ds_list_destroy(global.Line.LineColor);
	ds_list_destroy(global.Line.LineProperties);
	ds_list_destroy(global.Line.LineFadeProperties);
	ds_list_destroy(global.Line.LineDuration);
	ds_list_destroy(global.Line.LineLayer);
	delete global.Line;
	Timer = -1;
	FadingLines = 0;
	FadingPosition = -1;
	FadingAlpha = -1;
	FadingAlphaFade = -1;
	FadingLineParentIndex = -1;
}

///@desc Removes the line from the global line library
///@param {real} The index of the line to remove
function LineSystem_RemoveLine(index)
{
	global.Line.Lines--;
	ds_list_delete(global.Line.LinePoints, index);
	ds_list_delete(global.Line.LineWidth, index);
	ds_list_delete(global.Line.LineSpeed, index);
	ds_list_delete(global.Line.LineDirection, index);
	ds_list_delete(global.Line.LineAlpha, index);
	ds_list_delete(global.Line.LineAlphaFade, index);
	ds_list_delete(global.Line.LineColor, index);
	ds_list_delete(global.Line.LineProperties, index);
	ds_list_delete(global.Line.LineFadeProperties, index);
	ds_list_delete(global.Line.LineDuration, index);
	ds_list_delete(global.Line.LineLayer, index);
	array_delete(oLineSystem.Timer, index, 1);
	show_debug_message("Removed a line, current line amount is " + string(global.Line.Lines));
}

///@desc Creates a fading line
///@param {real} Duration	The duration of the line
///@param {real} Index Put index of the current line
function LineSystem_CreateFadeLine(duration, index)
{
	//Adds the amount of fading lines
	FadingLines++;
	//Pushes the array of fading line data
	array_push(FadingPosition, global.Line.LinePoints[| index]);
	array_push(FadingAlpha, 1);
	array_push(FadingAlphaFade, duration);
	array_push(FadingLineParentIndex, index);
	show_debug_message("Created a fading line, current fading line amount is " + string(FadingLines));
}

///@desc Remove a fading line
///@param {real} index The index of the line to remove
function LineSystem_RemoveFadingLine(index)
{
	//Reduces the amount of fading lines
	FadingLines--;
	//Deletes the array slot of the faded line
	array_delete(FadingPosition, index, 1);
	array_delete(FadingAlpha, index, 1);
	array_delete(FadingAlphaFade, index, 1);
	array_delete(FadingLineParentIndex, index, 1);
	show_debug_message("Removed a fading line, current amount of fading lines are " + string(FadingLines));
}

///@desc Fills in the empty slots of the arrays of the DS_Lists of the Line Library
function LineSystem_FillEmptySlots()
{
	var LineAmount = global.Line.Lines,
		Lists = [
					global.Line.LinePoints,
					global.Line.LineWidth,
					global.Line.LineDirection,
					global.Line.LineSpeed,
					global.Line.LineAlpha,
					global.Line.LineAlphaFade,
					global.Line.LineColor,
					global.Line.LineProperties,
					global.Line.LineFadeProperties,
					global.Line.LineDuration,
					global.Line.LineLayer
				],
		LineOtherAmount	 = [
			[ds_list_size(Lists[0])	, [0, 0, 0, 0]],
			[ds_list_size(Lists[1])	, 5],
			[ds_list_size(Lists[2])	, 0],
			[ds_list_size(Lists[3])	, 0],
			[ds_list_size(Lists[4])	, 1],
			[ds_list_size(Lists[5])	, 0],
			[ds_list_size(Lists[6])	, c_white],
			[ds_list_size(Lists[7])	, [LineProperties.NONE]],
			[ds_list_size(Lists[8])	, LineEndProperty.NONE],
			[ds_list_size(Lists[9])	, 60],
			[ds_list_size(Lists[10]), LineLayer.BELOW]
		];
	for(var i = 0, n = array_length(LineOtherAmount); i < n; ++i)
	{
		if LineAmount > LineOtherAmount[i, 0]
		{
			//If the line amount is larger than the current list size, add the default value to the list
			ds_list_add(Lists[i], LineOtherAmount[i, 1]);
		}
		else if LineAmount < LineOtherAmount[i, 0]
		{
			//If the line amount is less than the current list size, show error
			show_error("The value of the list " + string(i) + " is less than the total amount of lines", true);
		}
	}
}

///@desc Creates a Normal Line
///@param {real} x1	The x position of the head of the line
///@param {real} y1	The y position of the head of the line
///@param {real} x2	The x position of the end of the line
///@param {real} y2 The y position of the end of the line
///@param {real} width	The width of the line
///@param {Constant.Color} color The color of the line (Default c_white)
///@param {real} speed	The speed of the line
///@param {real} direction The direction of the line (Don't confuse it with angle)
function CreateNormalLine(x1, y1, x2, y2, width, color = c_white, spd = 0, dir = 0)
{
	CheckLineSystemExists();
	global.Line.Lines++;
	ds_list_add(global.Line.LinePoints, [x1, y1, x2, y2]);
	ds_list_add(global.Line.LineWidth, width);
	ds_list_add(global.Line.LineColor, color);
	ds_list_add(global.Line.LineSpeed, spd);
	ds_list_add(global.Line.LineDirection, dir);
	array_push(oLineSystem.Timer, 0);
	LineSystem_FillEmptySlots();
	show_debug_message("Line is created at: " + string(x1) + ", " + string(y1) + ", " + string(x2) + ", " + string(y2) + " with width of " + string(width) + " pixels");
	show_debug_message("Current line amount is " + string(global.Line.Lines));
	//Returns the index of the line for value changing
	return global.Line.Lines - 1;
}

///@desc Set the properties of the line
///@param {real} index	The index of the line
///@param {real} property	The property to change (Use the macros of SetLineProperty)
///@param value The value to change the property into
function SetLineProperties(index, prop, value)
{
	var Lists = [
					global.Line.LineSpeed,
					global.Line.LineDirection,
					global.Line.LineWidth,
					global.Line.LineAlpha,
					global.Line.LineAlphaFade,
					global.Line.LineColor,
					global.Line.LineProperties,
					global.Line.LineFadeProperties,
					global.Line.LineDuration,
					global.Line.LineLayer
				],
		n = array_length(Lists);
	if prop < 0	//If porperty input is smaller than 0 (Outside bounds)
		show_error("The property value must be larger than 0", true);
	else if prop > n //If porperty input is larger than list size (Outside bounds)
		show_error("The property value must be smaller than " + string_length(n), true);
	else Lists[prop][| index] = value; //If porperty input is within bounds, change the value
}