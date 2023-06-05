var input_confirm = input_check_pressed("confirm"),
	collide = instance_place(x, y, oOWPlayer);
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
		depth = oOWPlayer.depth + 9;
		image_speed = .15;
		var input = [
						input_check("right"), input_check("up"),
						input_check("left"), input_check("down")
					];
		if collide
		{
			if input_confirm and !Collided
			{
				Collided = true;
				OW_Dialog("You are filled with...\n[delay,333]  DETERMINATION");
				oOWController.Saving = true;
				oOWController.menu_disable = true;
			}
			with oOWPlayer
			{
				//Placeholder collision method
				if x > other.x and input[2]
				or x < other.x and input[0]
				or y > other.y and input[1]
				or y < other.y and input[3]
				{
					x = xprevious;
					y = yprevious;
				}
			}
		}
		var bloomIntensity = shader_get_uniform(shd_Bloom, "intensity"),
			bloomblurSize = shader_get_uniform(shd_Bloom, "blurSize");
		shader_set(shd_Bloom);
		shader_set_uniform_f(bloomIntensity, dsin(global.timer * 3) * 0.2 + 0.8);
		shader_set_uniform_f(bloomblurSize, 1 / display_get_width());
		draw_self();
		shader_reset();
	break
	case sprPixel:
		if collide and !Collided
		{	
			if Event != -1 and is_method(Event)
			{
				Collided = true;
				Event();
			}
		}
		else if collide and Collided
		{
			Collided = 2;
		}
		if !collide and Collided == 2 Collided = false;
	break
}

show_hitbox(c_purple);
