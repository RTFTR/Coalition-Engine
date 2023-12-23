///Shows the hitbox of the object (by it's sprite collision box)
///@param {color} Color	The color of the collision box
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
///Draws the debug UI with respect to the room you are in (by checking the controller isntance)
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
			var ca = global.timer, dis = lengthdir_x(20, global.timer * 3);
			static color = [c_red, c_lime, c_blue];
			for (var i = 0; i < 3; ++i)
				draw_text_ext_transformed_color(ui_x - 245 + lengthdir_y(dis, ca - i * 120), ui_y + lengthdir_x(dis, ca - i * 120), "DEBUG", -1, -1, 1.25, 1.25, 0, color[0], color[2 - i], color[2 - i], color[2 - i], debug_alpha);
		}
		
		draw_debug_color_text(5, 10, string("SPEED: {0}x ({1} FPS)", room_speed / 60, room_speed));
		draw_debug_color_text(5, 35, string("FPS: {0} ({1})", fps, fps_real));
		draw_debug_color_text(5, 60, "TURN: " + string(battle_turn));
		draw_debug_color_text(5, 85, "INSTANCES: " + string(instance_count));
		gpu_set_blendmode(bm_normal);
	}
	
	//If is in overworld
	elif instance_exists(oOWController)
	{
		gpu_set_blendmode(bm_add);
		var mx = window_mouse_get_x(), my = window_mouse_get_y();
		draw_debug_color_text(5, 5, string("Char Position : {0}, {1}", oOWPlayer.x, oOWPlayer.y));
		draw_debug_color_text(5, 25, string("Mouse Position : {0}, {1}", mx, my));
		draw_debug_color_text(5, 45, string("Camera Position : {0}, {1}", camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[1])));
		var inst = instance_position(mouse_x, mouse_y, all), inst_name = "";

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

/**
	Engine internal error log function to let you see what went wrong
	@param {bool} check		The statement to check whether there is an error or not
	@param {string} text	The return string of the error
*/
function __CoalitionEngineError(check, text)
{
	if !ERROR_LOG exit;
	if check show_error("Coalition Engine: " + text, true);
}

function __CoalitionGMVersion() {
	static _version = undefined;
	if _version != undefined return _version;
	
	var _pos = 1,
		_version_str = GM_runtime_version,
		_number_str = undefined;
	_version = {
		major: 0,
		minor: 0,
		bug_fix: 0,
		build_number: 0
	};
	
	//Using the most appropriate methods in order to maximize compatibility down to 2.3.0
	_pos = string_pos(".", _version_str);
	_number_str = string_copy(_version_str, 1, _pos-1);
	if string_length(string_digits(_number_str)) > 0 _version.major = real(_number_str);
	_version_str = string_delete(_version_str, 1, _pos);
	
	_pos = string_pos(".", _version_str);
	_number_str = string_copy(_version_str, 1, _pos-1);
	if string_length(string_digits(_number_str)) > 0 _version.minor = real(_number_str);
	_version_str = string_delete(_version_str, 1, _pos);
	
	_pos = string_pos(".", _version_str);
	_number_str = string_copy(_version_str, 1, _pos-1);
	if string_length(string_digits(_number_str)) > 0 _version.bug_fix = real(_number_str);
	_version_str = string_delete(_version_str, 1, _pos);
	 
	_number_str = string_copy(_version_str, 1, _pos-1);
	if string_length(string_digits(_number_str)) > 0 _version.build_number = real(_number_str);

	return _version;
}

function __CoalitionCheckCompatibilty()
{
	var version = __CoalitionGMVersion();
	if version.major >= 2024 or (version.major == 2023 && version.minor > 2)
		print("Coalition Engine ", ENGINE_VERSION, "was designed for Game Maker versions 2023.2 to 2023.8, you are in ", GM_runtime_version);
	if version.major < 2023
		print("Coalition Engine ", ENGINE_VERSION, "may be unstable for Game Maker versions earlier than 2023.2, you are in ", GM_runtime_version);
}