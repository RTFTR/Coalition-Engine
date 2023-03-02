///@desc Background Lines
var LineAmount = global.Line.Lines;
for(var i = 0; i < LineAmount; ++i)
{
	if global.Line.LineLayer[| i] == LineLayer.BELOW
	{
		var LinePoints = global.Line.LinePoints[| i];
		draw_set_alpha(global.Line.LineAlpha[| i]);
		draw_set_color(global.Line.LineColor[| i]);
		draw_line_width(LinePoints[0], LinePoints[1], LinePoints[2], LinePoints[3], global.Line.LineWidth[| i]);
	}
}

//Fading lines
if FadingLines > 0
{
	for(var i = 0; i < FadingLines; ++i)
	{
		var n = FadingLineParentIndex[i];
		var LinePoints = FadingPosition[i];
		draw_set_alpha(FadingAlpha[i]);
		draw_set_color(global.Line.LineColor[| n]);
		draw_line_width(LinePoints[0], LinePoints[1], LinePoints[2], LinePoints[3], global.Line.LineWidth[| n]);
	}
}

draw_set_alpha(1);
draw_set_color(c_white);

