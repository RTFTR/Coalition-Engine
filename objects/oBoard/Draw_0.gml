var _color = image_blend,
	_angle = image_angle,
	_alpha = image_alpha,
	_frame_x = frame_x,
	_frame_y = frame_y,
	_frame_w = frame_w,
	_frame_h = frame_h;

if !VertexMode
{
	surface_set_target(surface);
	draw_clear_alpha(c_white, 0);
	draw_clear_alpha(c_black, 0);
	draw_sprite_ext(sprPixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, c_white, _alpha);
	surface_reset_target()
	//Draws the board frame
	for (var i = 0; i < 4; ++i)
		draw_sprite_ext(sprPixel, 0, _frame_x[i], _frame_y[i], _frame_w[i], _frame_h[i], _angle, _color, _alpha);

	//Drawing of the Cover Board
	var i = 0;
	repeat(instance_number(oBoardCover)) {
		var BoardCoverID = instance_find(oBoardCover, i);
	
		draw_surface_part(BoardCoverID.surface, bg_x, bg_y, bg_w + 10, bg_h + 10,
							x - lengthdir_x(bg_w / 2, image_angle) - 5 * dcos(image_angle),
							y - lengthdir_x(bg_h / 2, image_angle) - 5 * -dsin(image_angle));
		++i;
	}
}
else
{
	//masking tbd
	var i = 0, n = array_length(Vertex);
	repeat n - 1
	{
		draw_line_width_color(Vertex[i][0], Vertex[i][1], Vertex[i + 1][0], Vertex[i + 1][1], 5, image_blend, image_blend);
		++i;
	}
}

image_blend = _color;
image_angle = _angle;
image_alpha = _alpha;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;

//draw_set_color(c_lime);
//for (var i = 0; i < 10; i += 2) {
//	draw_line_width(Vertex[i], Vertex[i + 1], Vertex[posmod(i + 2, 10)], Vertex[posmod(i + 3, 10)], 5)
//}
//draw_set_color(c_white);