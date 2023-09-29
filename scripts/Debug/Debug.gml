///@desc Shows the hitbox of the object (by it's sprite collision box)
///@param {Constant.Color} Color	The color of the collision box
function show_hitbox(col = c_white)
{
	if global.show_hitbox
	{
		var al = draw_get_alpha();
		draw_set_alpha(0.4);
		draw_set_color(col);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 0);
		draw_set_alpha(al);
	}
}

///Feather ignore all
///@desc Draws the debug UI with respect to the room you are in (by checking the controller isntance)
function DrawDebugUI()
{
	static draw_debug_color_text = function(x, y, text)
	{
		static color = make_color_hsv(global.timer % 255, 255, 255);
		draw_text_color(x, y, text, c_white, color, c_black, color, debug_alpha);
	}
	//Set debug alpha
	debug_alpha = lerp(debug_alpha, ALLOW_DEBUG ? global.debug : 0, 0.12);
	//Don't run anything if debug ui is not visible
	if debug_alpha <= 0 exit;
	
	draw_set_alpha(debug_alpha);
	draw_set_font(fnt_mnc);
	//If is in battle
	if instance_exists(oBattleController)
	{
		gpu_set_blendmode(bm_add);
		if !global.CompatibilityMode
		{
			var ca = global.timer,
				dis = dcos(global.timer * 3) * 20,
				color = [
					c_red,
					c_lime,
					c_blue
				];
			for (var i = 0; i < 3; ++i)
				draw_text_ext_transformed_color(ui_x - 245 - dsin(ca - i * 120) * dis, ui_y + dcos(ca - i * 120) * dis, "DEBUG", -1, -1, 1.25, 1.25, 0, color[0], color[2 - i], color[2 - i], color[2 - i], debug_alpha);
		}
		
		draw_debug_color_text(5, 10, string("SPEED: {0}x ({1} FPS)", room_speed / 60, room_speed));
		draw_debug_color_text(5, 35, string("FPS: {0} ({1})", fps, fps_real));
		draw_debug_color_text(5, 60, "TURN: " + string(battle_turn));
		draw_debug_color_text(5, 85, "INSTANCES: " + string(instance_count));
		gpu_set_blendmode(bm_normal);
	}
	
	//If is in overworld
	else if instance_exists(oOWController)
	{
		gpu_set_blendmode(bm_add);
		var mx = window_mouse_get_x(),
			my = window_mouse_get_y();
		draw_debug_color_text(5, 5, string("Char Position : {0}, {1}", oOWPlayer.x, oOWPlayer.y));
		draw_debug_color_text(5, 25, string("Mouse Position : {0}, {1}", mx, my));
		draw_debug_color_text(5, 45, string("Camera Position : {0}, {1}", camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[1])));
		var inst = instance_position(mouse_x, mouse_y, all),
			inst_name = "";

		//Naming
		if inst != noone
		{
			switch object_get_name(inst.object_index)
			{
				case "oOWPlayer":
					inst_name = "Player";
				break
				case "oOWCollision":
					switch inst.sprite_index
					{
						case sprOWSave:
							inst_name = "Save Point";
						break
					}
				break
			}
			draw_debug_color_text(5, 65, "Pointing At : " + inst_name);
		}
		draw_set_halign(fa_right);
		draw_debug_color_text(635, 5, string("FPS: {0} ({1})", fps, fps_real));
		draw_set_halign(fa_left);
		gpu_set_blendmode(bm_normal);
	}
	draw_set_alpha(1);
	draw_set_color(c_white);
}
