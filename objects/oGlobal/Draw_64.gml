//Quit Texts
if quit_timer
	draw_sprite_ext(sprQuitMesssge, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 15);

//Fader
draw_set_color(fader_color);
draw_set_alpha(fader_alpha);
draw_rectangle(0, 0, 640, 480, false);
draw_set_color(c_white);
draw_set_alpha(1);

//Effect drawing
if !instance_exists(blur_shader) and !instance_exists(shaderEffect) and room = room_battle
for (var i = 0, n = array_length(effect_shader); i < n; ++i)
{
	if !surface_exists(effect_surf[i]) effect_surf[i] = surface_create(640, 960);
	
	surface_set_target(effect_surf[i]);
	shader_set(effect_shader[i]);
	if effect_param[i, 0] != ""
	for(var ii = 0, nn = array_length(effect_param)/2; ii < nn; ++ii)
	{
		var shd_u = shader_get_uniform(effect_shader[i],effect_param[i, ii * 2])
		shader_set_uniform_f(shd_u, effect_param[i, ii * 2 + 1]);
	}
	draw_surface(application_surface, 0, 0);
	surface_reset_target();
	shader_reset();
	draw_surface(effect_surf[i], 0, 0);
}
//draw_text(10,100,camera_shake_i)
//draw_text(10,120,camera_get_view_x(view_camera[0]))
