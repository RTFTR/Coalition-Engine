if !pause
{
	var input_horizontal = input_check("right") - input_check("left");
	var input_vertical =   input_check("down") - input_check("up");
	var input_confirm =    input_check("confirm");
	var input_cancel =     input_check("cancel");
	var spd = 2 + input_cancel;
	var scale_x = last_dir;
	var assign_sprite = last_sprite;


	if !char_moveable spd = 0;

	if input_horizontal != 0
	{
		assign_sprite = dir_sprite[2];
		scale_x = -sign(input_horizontal);
		x += input_horizontal * spd;
	}
	if input_vertical != 0
	{
		scale_x = 1;
		if input_vertical == 1 assign_sprite = dir_sprite[1];
		if input_vertical == -1 assign_sprite = dir_sprite[0];
		y += input_vertical * spd
	}


	if !char_moveable {assign_sprite = last_sprite; scale_x = last_dir;}

	image_xscale = scale_x;
	if assign_sprite != -1 sprite_index = assign_sprite;
	if x != xprevious or y != yprevious image_index += 0.2;
	else image_index = 0;


	draw_self();

	last_sprite = assign_sprite;
	last_dir = scale_x;
}
draw_text(10,10,pause)
