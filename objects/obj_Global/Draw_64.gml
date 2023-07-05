// Quit Text
if quit_timer
	draw_sprite_ext(sprQuitMesssge, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 15);

// Effect drawing
if !instance_exists(obj_BlurShader) and !instance_exists(obj_ShaderEffect) and room == room_battle and effect_shader != []
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

// Fader
if fader_alpha > 0
{
	draw_sprite_ext(sprPixel, 0, 0, 0, 640, 480, 0, fader_color, fader_alpha);
}

// Song Name
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

#region Debugger
gpu_set_blendmode(bm_add);
debug_alpha = lerp(debug_alpha, global.debug, 0.12);
draw_set_alpha(debug_alpha);
draw_set_font(fnt_dt_sans);
var col = make_color_hsv(global.timer % 255, 255, 255),
	mx = window_mouse_get_x(),
	my = window_mouse_get_y();
//draw_text_color(5, 5, "Char Position : " + string(obj_OverworldCharMain.x) + ", " + string(obj_OverworldCharMain.y), c_white, col, c_black, col, debug_alpha)
draw_text_ext_transformed_color(5, 0, "Mouse Position : " + string(mx) + ", " + string(my), -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha)
draw_text_ext_transformed_color(5, 15, "Current Room : " + string(room_get_name(room)), -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha)
draw_text_ext_transformed_color(5, 30, "Speed: " + string(room_speed / 60) + "x (" + string(room_speed) + " FPS)", -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha)
draw_text_ext_transformed_color(5, 45, "Instances: " + string(instance_count), -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha)

if instance_exists(obj_BattleController)
{	
	draw_set_halign(fa_right);
	draw_text_ext_transformed_color(635, 15, "Turn: " + string(obj_BattleController.battle_turn), -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha)
}

//draw_text_color(5, 65, "Camera Position : " + string(obj_Global.camera_x) + ", " + string(obj_Global.camera_y), c_white, col, c_black, col, debug_alpha)
var inst = instance_position(mouse_x, mouse_y, all);
var inst_name = "";

//Naming
//if inst != noone
//{
//	switch object_get_name(inst.object_index)
//	{
//		case "obj_OverworldCharMain":
//			inst_name = "Player";
//		break
//		case "obj_OverworldCollision":
//		switch inst.sprite_index
//		{
//			case sprOWSave:
//				inst_name = "Save Point";
//			break
//		}
//		break
//	}
//}
//else inst_name = "Nothing";

//draw_text_ext_transformed_color(5, 45, "Pointing At : " + inst_name, -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha);
draw_set_halign(fa_right);
draw_text_ext_transformed_color(635, 0, "FPS: " + string(fps) + " (" + string(fps_real) + ")", -1, -1, 0.5, 0.5, 0, c_white, col, c_white, col, debug_alpha);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);
#endregion

// Tip thing
//if room == rRestart
//{
//	var text = "[fa_center][c_white][fnt_dt_mono]Restarting",
//		num = restart_timer div 10;
//	num %= 4;
//	repeat num text += ".";
//	draw_text_scribble(320, 240, text);
//	draw_text_scribble(320, 420, "[fa_center][c_ltgray][fnt_dotum]" + restart_tip);
//}