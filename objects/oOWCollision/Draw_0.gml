var input_confirm = input_check_pressed("confirm");
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
	depth = oOWPlayer.depth + 9;
	image_speed = .15;
	if TextTime TextTime++;
	var collide = instance_place(x, y, oOWPlayer),
		input = [
			input_check("right"), input_check("up"),
			input_check("left"), input_check("down")
				];
	if collide
	{
		if input_confirm and TextTime == 0
		{
			TextTime++
			OW_Dialog("You are filled with...\n[delay,333]  DETERMINATION");
			oOWController.Saving = true;
		}
		with oOWPlayer
		{
			//Placeholder collision method
			if x > other.x and input[2]
			or x < other.x and input[0]
			or y > other.y and input[1]
			or y < other.y and input[3]
				char_moveable = 0;
		}
	}
	var bloomIntensity = shader_get_uniform(shd_Bloom, "intensity"),
		bloomblurSize = shader_get_uniform(shd_Bloom, "blurSize");
	shader_set(shd_Bloom);
	shader_set_uniform_f(bloomIntensity, dsin(global.timer * 3) * 0.5 + 0.5);
	shader_set_uniform_f(bloomblurSize, 1/display_get_width());
	draw_self();
	shader_reset();
	if TextTime > 1 and !oOWController.is_dialog TextTime = 0;
	break
}

show_hitbox(c_purple);

collide = false;