///@desc Very cringe attempt, ignore
//if !global.CompatibilityMode
{
	if !surface_exists(surf) surf = surface_create(640, 960);
	surface_set_target(surf)
	shader_set(effect_shader);
	var i = 0;
	repeat array_length(effect_param)
	{
		var shd_u = shader_get_uniform(effect_shader, effect_param[i][0])
		shader_set_uniform_f_array(shd_u, effect_param[i][1]);
		++i;
	}
	draw_surface(application_surface, 0, 0);
	surface_reset_target();
	shader_reset();
	draw_surface(surf, 0, 0);
}