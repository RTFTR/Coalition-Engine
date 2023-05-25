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
var def_text = "The amount of ";
var def_text2 = " of the lines is ";
var cor_str = string(LineAmount);
if LineAmount != LinePointsAmount			show_error(def_text + "points" + def_text2 +		string(LinePointsAmount) + " not " +		cor_str, true);
if LineAmount != LineWidthAmount			show_error(def_text + "width" + def_text2+			string(LineWidthAmount) + " not " +			cor_str, true);
if LineAmount != LineSpeedAmount			show_error(def_text + "speed" + def_text2+			string(LineSpeedAmount) + " not " +			cor_str, true);
if LineAmount != LineDirectionAmount		show_error(def_text + "direction" + def_text2+		string(LineDirectionAmount) + " not " +		cor_str, true);
if LineAmount != LineAlphaAmount			show_error(def_text + "alpha" + def_text2+			string(LineAlphaAmount) + " not " +			cor_str, true);
if LineAmount != LineAlphaFadeAmount		show_error(def_text + "alpha fade" + def_text2 +	string(LineAlphaFadeAmount) + " not " +		cor_str, true);
if LineAmount != LineColorAmount			show_error(def_text + "color"+ def_text2 +			string(LineColorAmount) + " not " +			cor_str, true);
if LineAmount != LinePropertiesAmount		show_error(def_text + "properties" + def_text2+		string(LinePropertiesAmount) + " not " +	cor_str, true);
if LineAmount != LineFadePropertiesAmount	show_error(def_text + "fade properties"+ def_text2 +string(LineFadePropertiesAmount) + " not " + cor_str, true);
if LineAmount != LineDurationAmount			show_error(def_text + "duration" + def_text2+		string(LineDurationAmount) + " not " +		cor_str, true);
if LineAmount != LineLayerAmount			show_error(def_text + "layer" + def_text2+			string(LineLayerAmount) + " not " +			cor_str, true);

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
	
	//If the duration is (less than or)equal to 0
	if Duration <= 0
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
	var MoveX = global.Line.LineSpeed[| i] * dcos(global.Line.LineDirection[| i]);
	var MoveY = global.Line.LineSpeed[| i] * -dsin(global.Line.LineDirection[| i]);
	
	//Line movement
	global.Line.LinePoints[| i] = 
	[
		LinePoints[0] + MoveX,
		LinePoints[1] + MoveY,
		LinePoints[2] + MoveX,
		LinePoints[3] + MoveY,
	];
	
	//Special Properties of the lines
	var NormalProperty = global.Line.LineProperties[| i];
	
	//If the input isn't an array, show the error
	if !is_array(NormalProperty)
		show_error("The property value is not an array, the correct format should be [Property, argument...]", true);
	else var n = array_length(NormalProperty);
	
	switch NormalProperty[0]
	{
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