var input_confirm = input_check_pressed("confirm")
//Properties of Save (INCOMPLETE)
if sprite_index == spr_ow_save
{
	image_speed = .15;
	if collide and !texted
		if input_confirm
		{
			texted = true;
			OW_Dialog("You are filled with...\n[pause,333]  DETERMINATION")
		}
	var bloomIntensity = shader_get_uniform(shd_Bloom, "intensity");
	var bloomblurSize = shader_get_uniform(shd_Bloom, "blurSize");
	shader_set(shd_Bloom);
	shader_set_uniform_f(bloomIntensity, sin(degtorad(global.timer * 3)) * 0.5 + 0.5);
	shader_set_uniform_f(bloomblurSize, 1/display_get_width());
	draw_self();
	shader_reset();
	if texted and !oOWController.is_dialog
		texted = false;
}

show_hitbox(c_purple);

collide = false;