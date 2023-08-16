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
	//Set debug alpha 
	debug_alpha = lerp(debug_alpha, ALLOW_DEBUG ? global.debug : 0, 0.12);
	//Don't run anything if debug ui is not visible
	if debug_alpha <= 0 exit;
	
	draw_set_alpha(debug_alpha);
	draw_set_font(fnt_mnc);
	var col = make_color_hsv(global.timer % 255, 255, 255);
	//If is in battle
	if instance_exists(oBattleController)
	{
		var ca = global.timer,
			dis = dcos(global.timer * 3) * 20,
			debug_pos = [
				[ui_x - 245 - dsin(ca)		 * dis, ui_y + dcos(ca)			* dis],
				[ui_x - 245 - dsin(ca + 120) * dis, ui_y + dcos(ca + 120)	* dis],
				[ui_x - 245 - dsin(ca + 240) * dis, ui_y + dcos(ca + 240)	* dis]
			],
			color = [
				c_red,
				c_lime,
				c_blue
			];
		if !global.CompatibilityMode
		{
			gpu_set_blendmode(bm_add);
			for (var i = 0; i < 3; ++i)
				draw_text_ext_transformed_color(debug_pos[2 - i, 0], debug_pos[2 - i, 1], "DEBUG", -1, -1, 1.25, 1.25, 0, color[0], color[2 - i], color[2 - i], color[2 - i], debug_alpha);
			gpu_set_blendmode(bm_normal);
		}
		
		draw_text_ext_transformed_color(5, 10, "SPEED: " + string(room_speed / 60) + "x (" + string(room_speed) + " FPS)", -1, -1, 1, 1, 0, c_white, col, c_black, col, debug_alpha)
		draw_text_ext_transformed_color(5, 35, "FPS: " + string(fps) + " (" + string(fps_real) + ")", -1, -1, 1, 1, 0, c_white, col, c_black, col, debug_alpha)
		draw_text_ext_transformed_color(5, 60, "TURN: " + string(battle_turn), -1, -1, 1, 1, 0, c_white, col, c_black, col, debug_alpha)
		draw_text_ext_transformed_color(5, 85, "INSTANCES: " + string(instance_count), -1, -1, 1, 1, 0, c_white, col, c_black, col, debug_alpha)
	}
	
	//If is in overworld
	if instance_exists(oOWController)
	{
		gpu_set_blendmode(bm_add);
		var mx = window_mouse_get_x(),
			my = window_mouse_get_y();
		draw_text_color(5, 5, "Char Position : " + string(oOWPlayer.x) + ", " + string(oOWPlayer.y), c_white, col, c_black, col, debug_alpha);
		draw_text_color(5, 25, "Mouse Position : " + string(mx) + ", " + string(my), c_white, col, c_black, col, debug_alpha);
		draw_text_color(5, 45, "Camera Position : " + string(camera_get_view_x(view_camera[0])) + ", " + string(camera_get_view_y(view_camera[0])), c_white, col, c_black, col, debug_alpha);
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
			draw_text_color(5, 65, "Pointing At : " + inst_name, c_white, col, c_black, col, debug_alpha);
		}
		draw_set_halign(fa_right);
		draw_text_color(635, 5, "FPS: " + string(fps) + " (" + string(fps_real) + ")", c_white, col, c_black, col, debug_alpha);
		draw_set_halign(fa_left);
		gpu_set_blendmode(bm_normal);
	}
	draw_set_alpha(1);
	draw_set_color(c_white);
}
