//Very cringe attempt, ignore
if !surface_exists(surf) surf = surface_create(640, 960);
surface_set_target(surf)
shader_set(effect_shader);
if effect_param[0] != ""
for(var ii = 0, nn = array_length(effect_param)/2; ii < nn; ++ii)
{
	var shd_u = shader_get_uniform(effect_shader,effect_param[ii * 2])
	shader_set_uniform_f(shd_u, effect_param[ii * 2 + 1]);
}
draw_surface(application_surface, 0, 0);
surface_reset_target();
shader_reset();
draw_surface(surf, 0, 0);