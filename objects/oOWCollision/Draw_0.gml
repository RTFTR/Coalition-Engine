var input_confirm = input_check_pressed("confirm"),
	collide = instance_place(x, y, oOWPlayer);
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
		if collision_rectangle(x - 7, y - 7, x + 7, y + 7, oOWPlayer, 1, 1)
		and !oOWController.Saving
			if input_confirm
			{
				Collided = true;
				OW_Dialog("You are filled with...\n[delay,333]  DETERMINATION");
				oOWController.Saving = true;
				oOWController.menu_disable = true;
			}
		if collide
		{
			with oOWPlayer
			{
				//Placeholder collision method
				if x > other.x and input_check("left")
				or x < other.x and input_check("right")
				or y > other.y and input_check("up")
				or y < other.y and input_check("down")
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
}

show_hitbox(c_purple);
