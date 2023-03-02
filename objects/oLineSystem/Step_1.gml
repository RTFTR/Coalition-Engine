///@desc Updating Lines

//Variable Decleration
var	LineAmount				 = global.Line.Lines,
	LinePointsAmount		 = ds_list_size(global.Line.LinePoints),
	LineWidthAmount			 = ds_list_size(global.Line.LineWidth),
	LineDirectionAmount		 = ds_list_size(global.Line.LineDirection),
	LineSpeedAmount			 = ds_list_size(global.Line.LineSpeed),
	LineAlphaAmount			 = ds_list_size(global.Line.LineAlpha),
	LineAlphaFadeAmount		 = ds_list_size(global.Line.LineAlphaFade),
	LineColorAmount			 = ds_list_size(global.Line.LineColor),
	LinePropertiesAmount	 = ds_list_size(global.Line.LineProperties),
	LineFadePropertiesAmount = ds_list_size(global.Line.LineFadeProperties),
	LineDurationAmount		 = ds_list_size(global.Line.LineDuration),
	LineLayerAmount		 	 = ds_list_size(global.Line.LineLayer);

//Report error if arguments of the lines are incorrectly defined
if LineAmount != LinePointsAmount			show_error("The amount of points of the lines is " + string(LinePointsAmount) + " not " + string(LineAmount), true);
if LineAmount != LineWidthAmount			show_error("The amount of width of the lines is " + string(LineWidthAmount) + " not " + string(LineAmount), true);
if LineAmount != LineSpeedAmount			show_error("The amount of speed of the lines is " + string(LineSpeedAmount) + " not " + string(LineAmount), true);
if LineAmount != LineDirectionAmount		show_error("The amount of direction of the lines is " + string(LineDirectionAmount) + " not " + string(LineAmount), true);
if LineAmount != LineAlphaAmount			show_error("The amount of alpha of the lines is " + string(LineAlphaAmount) + " not " + string(LineAmount), true);
if LineAmount != LineAlphaFadeAmount		show_error("The amount of alpha fade of the lines is " + string(LineAlphaFadeAmount) + " not " + string(LineAmount), true);
if LineAmount != LineColorAmount			show_error("The amount of color of the lines is " + string(LineColorAmount) + " not " + string(LineAmount), true);
if LineAmount != LinePropertiesAmount		show_error("The amount of properties of the lines is " + string(LinePropertiesAmount) + " not " + string(LineAmount), true);
if LineAmount != LineFadePropertiesAmount	show_error("The amount of fade properties of the lines is " + string(LineFadePropertiesAmount) + " not " + string(LineAmount), true);
if LineAmount != LineDurationAmount			show_error("The amount of duration of the lines is " + string(LineDurationAmount) + " not " + string(LineAmount), true);
if LineAmount != LineLayerAmount			show_error("The amount of layer of the lines is " + string(LineLayerAmount) + " not " + string(LineAmount), true);

//Line Logic
//If no lines are active then don't run any code
if LineAmount == 0 exit;

for(var i = 0; i < LineAmount; ++i)
{
	//The vertexes of the line
	var LinePoints = global.Line.LinePoints[| i];
	
	
	//Terminate the line if it's duration is zero
	var Duration = global.Line.LineDuration[| i];
	
	//Stores the current line amount
	var CurrentLineAmount = global.Line.Lines;
	
	//If the duration is higher than  0, decrease it
	if Duration
		Duration--;
	
	//If the duration is 0
	if !Duration
	{
		var DestroyLine = false;
		//If the line has fading properties
		switch global.Line.LineFadeProperties[| i]
		{
			//If no special property then remove the line
			case LineEndProperty.NONE:
				LineSystem_RemoveLine(i);
				DestroyLine = true;
			break
				
			//Fade out lines with given fading time
			case LineEndProperty.FADEOUT:
				global.Line.LineAlpha[| i] -= 1 / global.Line.LineAlphaFade[| i];
				if global.Line.LineAlpha[| i] <= 0
				{
					LineSystem_RemoveLine(i);
					DestroyLine = true;
				}
			break
		}
		//Not execute the rest of the code if the line is destroyed to boost performance
		if DestroyLine exit;
	}
	//If no lines are destroyed, set the duration to it's new value
	if global.Line.Lines == CurrentLineAmount
		global.Line.LineDuration[| i] = Duration;
	
	//Gets the displacement of the line
	var Movement = lengthdir_xy(global.Line.LineSpeed[| i], global.Line.LineDirection[| i]);
	
	//Line movement
	global.Line.LinePoints[| i] = 
	[
		LinePoints[0] + Movement.x,
		LinePoints[1] + Movement.y,
		LinePoints[2] + Movement.x,
		LinePoints[3] + Movement.y,
	];
	
	//Special Properties of the lines
	var NormalProperty = global.Line.LineProperties[| i];
	
	//If the input isn't an array, show the error
	if !is_array(NormalProperty)
		show_error("The property value is not an array, the correct format should be [Property, argument...]", true);
	else var n = array_length(NormalProperty);
	
	switch NormalProperty[0]
	{
		case LineProperties.NONE: break
		case LineProperties.TRAIL:
			Timer[i]++;
			if n < 2
				show_error("The array must contain 3 values [Property, interval, Fade Speed]", true);
			
			if !(Timer[i] % NormalProperty[1])
			{
				if n < 3
					show_error("The array must contain 3 values [Property, interval, Fade Speed]", true);
				//If no errors then create the fading line
				LineSystem_CreateFadeLine(NormalProperty[2], i);
			}
		break
	}
	
	//Fading Lines
	for(var ii = 0; ii < FadingLines; ++ii)
	{
		FadingAlpha[ii] -= 1 / FadingAlphaFade[ii];
		if FadingAlpha[ii] <= 0 LineSystem_RemoveFadingLine(ii);
	}
}