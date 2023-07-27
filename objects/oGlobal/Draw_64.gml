//Quit Texts
if quit_timer
	draw_sprite_ext(sprQuitMesssge, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 15);

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
	draw_sprite_ext(sprPixel, 0, 0, 0, 640, 480, 0, fader_color, fader_alpha);
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
	draw_text_scribble(dist - Length + 10, 10, "[fnt_dt_sans][c_white]" + Text);
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
	var text = "[fa_center][c_white][fnt_dt_mono]Restarting",
		num = restart_timer div 10;
	num %= 4;
	repeat num text += ".";
	draw_text_scribble(320, 240, text);
	draw_text_scribble(320, 420, "[fa_center][c_ltgray][fnt_dotum]" + restart_tip);
}

//Gradient, will only run once to store the surface
if global.timer == 1
{
	surface_set_target(GradientSurf);
	shader_set(shdGradient);
	draw_sprite_ext(sprPixel, 0, 0, 0, 640, 480, 0, c_white, 1);
	shader_reset();
	surface_reset_target();
	shader_enable_corner_id(false);
}