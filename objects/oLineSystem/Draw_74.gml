///@desc Above Lines
//Draw GUI Begin to prevent the lines are above the global fader
var LineAmount = global.Line.Lines;
for(var i = 0; i < LineAmount; ++i)
{
	if global.Line.LineLayer[| i] == LineLayer.ABOVE
	{
		var LinePoints = global.Line.LinePoints[| i];
		draw_set_alpha(global.Line.LineAlpha[| i]);
		draw_set_color(global.Line.LineColor[| i]);
		draw_line_width(LinePoints[0], LinePoints[1], LinePoints[2], LinePoints[3], global.Line.LineWidth[| i]);
	}
}
draw_set_alpha(1);
draw_set_color(c_white);