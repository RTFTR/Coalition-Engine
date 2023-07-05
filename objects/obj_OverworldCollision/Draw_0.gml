var input_confirm = input_check_pressed("confirm"),
	collide = instance_place(x, y, obj_OverworldCharMain);
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
		if collision_rectangle(x - 7, y - 7, x + 7, y + 7, obj_OverworldCharMain, 1, 1)
		and !obj_OverworldController.Saving
			if input_confirm
			{
				Collided = true;
				OW_Dialog("You are filled with...\n[delay,333]  DETERMINATION");
				obj_OverworldController.Saving = true;
				obj_OverworldController.menu_disable = true;
			}
		if collide
		{
			with obj_OverworldCharMain
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
