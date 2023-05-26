//Quit Texts
if quit_timer
	draw_sprite_ext(sprQuitMesssge, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 15);

//Effect drawing
if !instance_exists(blur_shader) and !instance_exists(shaderEffect) and room == room_battle and effect_shader != []
{
	var i = 0;
	repeat(array_length(effect_shader))
	{
		if !surface_exists(effect_surf[i]) effect_surf[i] = surface_create(640, 960);
	
		surface_set_target(effect_surf[i]);
		shader_set(effect_shader[i]);
		if effect_param[i, 0] != ""
		{
			var ii = 0;
			repeat(array_length(effect_param) / 2)
			{
				var shd_u = shader_get_uniform(effect_shader[i],effect_param[i, ii * 2])
				shader_set_uniform_f(shd_u, effect_param[i, ii * 2 + 1]);
				ii++;
			}
		}
		draw_surface(application_surface, 0, 0);
		surface_reset_target();
		shader_reset();
		draw_surface(effect_surf[i], 0, 0);
		i++;
	}
}
//draw_text(10,100,camera_shake_i)
//draw_text(10,120,camera_get_view_x(view_camera[0]))

if RGBShake
{
	gpu_set_blendmode(bm_add);
	draw_surface_ext(application_surface, random_range(-RGBShake, RGBShake), random_range(-RGBShake, RGBShake), 1, 1, 0, c_red, 1);
	draw_surface_ext(application_surface, random_range(-RGBShake, RGBShake), random_range(-RGBShake, RGBShake), 1, 1, 0, c_lime, 1);
	draw_surface_ext(application_surface, random_range(-RGBShake, RGBShake), random_range(-RGBShake, RGBShake), 1, 1, 0, c_blue, 1);
	gpu_set_blendmode(bm_normal);
	RGBShake--;
}

//Fader
if fader_alpha > 0
{
	draw_set_color(fader_color);
	draw_set_alpha(fader_alpha);
	draw_rectangle(0, 0, 640, 480, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

//Song Name
if Song.Activate
{
	if (room == room_gameover && Song.Time < 180) Song.Time = 180;
	Song.Time++;
	var Text = "Now Playing: " + Song.Name,
		Length = string_width(Text),
		Height = string_height(Text) * 1.3,
		dist = Song.Dist;
	var col = [c_teal, c_purple];
	draw_rectangle_color(dist - 10, 10, dist - Length - 20, 15 + Height, col[0], col[1],
						col[1], col[0], false);
	draw_triangle_color(dist - 11, 10, dist + 20, (15 + Height + 10) / 2, dist - 11, 15 + Height,
						col[1], col[1], col[1], false);
	draw_set_font(fnt_dt_sans);
	draw_set_color(c_white);
	draw_text(dist - Length + 10, 15, Text);
	if Song.Time < 60
		Song.Dist = lerp(dist, Length, 0.21);
	if Song.Time > 180
		Song.Dist = lerp(dist, -20, 0.21);
	if Song.Time > 240
	{
		Song.Activate = false;
		Song.Time = 0;
		Song.Name = "";
	}
}

//Tip thing
if room == rRestart
{
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_set_font(fnt_dt_mono);
	var RestartTxt = ["Restarting", "Restarting.", "Restarting..",
					"Restarting..."],
		num = restart_timer div 10;
	num %= 4
	draw_text(320, 240, RestartTxt[num]);
	draw_set_color(c_ltgray);
	draw_set_font(fnt_dotum);
	draw_text(320, 420, restart_tip);
}