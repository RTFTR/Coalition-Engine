if active
{
	var sprite = object_get_sprite(object),
		index = 2,
		spacing = sprite_get_height(sprite),
		head = cone;
	if head == 2
	{
		index = 4;
		spacing -= 2;
	}
	//Color
	var color, color_outline;
	switch type
	{
		case 0: color = c_white;	break;
		case 1: color = c_aqua;		break;
		case 2: color = c_orange;	break;
	}
	color_outline = color;

	if time_warn
	{
		time_warn--;
		if width == -1
		{
			var FinalDir = round(image_angle / 90) * 90;
			width = point_distance(Board.GetLeftPos(), Board.GetUpPos(), Board.GetRightPos(), Board.GetDownPos());
		}
		//Since the centre position of the warning box is the x/y position, calculate the corner
		//positions of the warning box
		var TargetX = x, TargetY = y;
		//Apply first displacement
		TargetX -= lengthdir_x(width / 2 + 1, image_angle + 90);
		TargetY -= lengthdir_y(width / 2 + 1, image_angle + 90);
		//Top left corner (With respect to image_angle = 0)
		WarningBoxPos[# 0, 0] = TargetX + lengthdir_x(distance[1] - distance[0] - height / 2, image_angle);
		WarningBoxPos[# 0, 1] = TargetY + lengthdir_y(distance[1] - distance[0] - height / 2, image_angle);
		//Top Right corner
		WarningBoxPos[# 1, 0] = TargetX;
		WarningBoxPos[# 1, 1] = TargetY;
		//Apply second displacement
		TargetX += lengthdir_x(width + 1, image_angle + 90);
		TargetY += lengthdir_y(width + 1, image_angle + 90);
		//Bottom left corner (With respect to image_angle = 0)
		WarningBoxPos[# 3, 0] = TargetX + lengthdir_x(distance[1] - distance[0] - height / 2, image_angle);
		WarningBoxPos[# 3, 1] = TargetY + lengthdir_y(distance[1] - distance[0] - height / 2, image_angle);
		//Bottom Right corner
		WarningBoxPos[# 2, 0] = TargetX;
		WarningBoxPos[# 2, 1] = TargetY;
		Battle_Masking_Start();
		//Warn line
		for (var i = 0; i < 4; ++i) {
			draw_line_color(
				WarningBoxPos[# i, 0], WarningBoxPos[# i, 1],
				WarningBoxPos[# (i + 1) % 4, 0], WarningBoxPos[# (i + 1) % 4, 1],
				warn_color, warn_color);
		}
		//Fill area
		draw_set_alpha(warn_alpha_filled);
		draw_triangle_color(
			WarningBoxPos[# 0, 0], WarningBoxPos[# 0, 1],
			WarningBoxPos[# 1, 0], WarningBoxPos[# 1, 1],
			WarningBoxPos[# 2, 0], WarningBoxPos[# 2, 1],
			warn_color, warn_color, warn_color, false);
		draw_triangle_color(
			WarningBoxPos[# 2, 0], WarningBoxPos[# 2, 1],
			WarningBoxPos[# 3, 0], WarningBoxPos[# 3, 1],
			WarningBoxPos[# 0, 0], WarningBoxPos[# 0, 1],
			warn_color, warn_color, warn_color, false);
		draw_set_alpha(1);
		Battle_Masking_End();
	}
}