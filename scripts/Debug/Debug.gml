///@desc Shows the hitbox of the object (by it's sprite collision box)
///@param {Constant.Color} Color	The color of the collision box
function show_hitbox(col = c_white)
{
	if global.show_hitbox
	{
		var al = draw_get_alpha()
		draw_set_alpha(0.4)
		draw_set_color(col)
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 0)
		draw_set_alpha(al)
	}
}

