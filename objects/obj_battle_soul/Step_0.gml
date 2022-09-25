// Invincibility
if global.inv > 0
{
	global.inv--;
	if !global.kr_activation
	{
		if image_speed == 0
		{
			image_speed = 1/2;
			image_index = 1;
		}
	}
}
else
{
	if image_speed != 0
	{
		image_speed = 0;
		image_index = 0;
	}
}

// Mode
var STATE = obj_battle_controller.battle_state;
if (STATE == 2)
{
	if follow_board
	{
		x += obj_battle_board.x - obj_battle_board.xprevious;
		y += obj_battle_board.y - obj_battle_board.yprevious;
	}

	var h_spd = input_check("right") - input_check("left");
	var v_spd = input_check("down") - input_check("up");
		
	var move_spd = (global.spd / (input_check("cancel") + 1));
	
	var x_offset = sprite_width / 2;
	var y_offset = sprite_height / 2;
	
	var check_board = instance_exists(obj_battle_board);
	if check_board // When the board is real XD
	{
		var board = obj_battle_board;
		var board_x = board.x;
		var board_y = board.y;
		var board_angle = board.image_angle;
		var board_margin = [board.up, board.down, board.left, board.right];
		
		var board_top_limit    = (board_y - board_margin[0]) + y_offset;
		var board_bottom_limit = (board_y + board_margin[1]) - y_offset;
		var board_left_limit   = (board_x - board_margin[2]) + x_offset;
		var board_right_limit  = (board_x + board_margin[3]) - x_offset;
	}
	
	if mode == SOUL_MODE.RED // Red
	{
		move_x = h_spd * move_spd;
		move_y = v_spd * move_spd;
		var _angle = image_angle;
		
		if moveable == true
		{
			x += lengthdir_x(move_x, _angle);
			y += lengthdir_x(move_y, _angle);
		}
		image_angle = _angle;
	}
	
	else if mode == SOUL_MODE.BLUE // Blue
	{
		if (dir == DIR.DOWN) image_angle=0;
		else if (dir == DIR.UP) image_angle=180;
		else if (dir == DIR.LEFT) image_angle=270;
		else if (dir == DIR.RIGHT) image_angle=90;
			
		var _on_ground = false;
		var _on_ceil = false;
		var _on_platform = false;
		var _fall_spd = fall_spd;
		var _fall_grav = fall_grav;

		var _angle = image_angle;
		
		var platform_check_x = [0, 0];
		var platform_check_y = [0, 0];
		
		if _fall_spd < 4 and _fall_spd > 0.25 _fall_grav = 0.15;
		if _fall_spd <= 0.25 and _fall_spd > -0.5 _fall_grav = 0.05;
		if _fall_spd <= -0.5 and _fall_spd > -2 _fall_grav = 0.125;
		if _fall_spd <= -2 _fall_grav = 0.05;
	
		_fall_spd += _fall_grav;
	
		var _dist = point_distance(board_x, board_y, x, y);
		var _dir = point_direction(board_x, board_y, x, y);
		var r_x = lengthdir_x(_dist, _dir - board_angle) + board_x;
		var r_y = lengthdir_y(_dist, _dir - board_angle) + board_y;
		
		if _angle == 0
		{
			if check_board
			{
				_on_ground = r_y >= board_bottom_limit - 0.1;
				_on_ceil = r_y <= board_top_limit + 0.1;
			}
			
			platform_check_x = [0, 0];
			platform_check_y = [x_offset + 1, x_offset];
			
			jump_input = input_check("up");
			move_input = h_spd * move_spd;
		}
		if _angle == 180
		{
			if check_board
			{
				_on_ground = r_y <= board_top_limit + 0.1;
				_on_ceil = r_y >= board_bottom_limit - 0.1;
			}
			
			platform_check_x = [0, 0];
			platform_check_y = [y_offset - 1, -y_offset];
			
			jump_input = input_check("down");
			move_input = h_spd * -move_spd;
		}
		if _angle == 90
		{
			if check_board
			{
				_on_ground = r_x >= board_right_limit - 0.1;
				_on_ceil = r_x <= board_left_limit + 0.1;
			}
			
			platform_check_x = [x_offset - 1, -x_offset];
			platform_check_y = [0, 0];
			
			jump_input = input_check("left");
			move_input = v_spd * -move_spd;
		}
		if _angle == 270 or _angle == -90
		{
			if check_board
			{
				_on_ground = r_x <= board_left_limit + 0.1;
				_on_ceil = r_x >= board_right_limit - 0.1;
			}
			
			platform_check_x = [x_offset + 1, x_offset];
			platform_check_y = [0, 0];
			
			jump_input = input_check("left");
			move_input = v_spd * move_spd;
		}
		
		if !check_board 
		{ 
			_on_ground = false; 
			_on_ceil = false;
		}
		
		var platform_check = instance_position(x + platform_check_x[0], y + platform_check_y[0], battle_platform);
		
		if position_meeting(x + platform_check_x[0], y + platform_check_y[0], battle_platform) and _fall_spd >= 0
		{
			_on_platform = true;
			while position_meeting(x + platform_check_x[1], y + platform_check_y[1], battle_platform)
			{
				with platform_check
				{
					other.x += lengthdir_x(0.1, image_angle + 90);
					other.y += lengthdir_y(0.1, image_angle + 90);
				}
			}
		}
		with platform_check
		{
			if platform_check.sticky
			{
				other.x += hspeed;
				other.y += vspeed;
			}
		}
		
		if _on_ground or _on_platform or (_fall_spd < 0 and _on_ceil)
		{
			if slam
			{
				slam = false;
				//Camera_Shake(global.slam_power/2,global.slam_power/2,1,1,true,true);
				if global.slam_damage
				{
					if global.hp > 1 global.hp--;
					else global.hp = 1;
				}
			
				audio_stop_sound(snd_impact);
				audio_play_sound(snd_impact, 50, false);
			}
		
			_fall_spd = 0;
			if (_on_ground or _on_platform) and ((mode == 2 and jump_input) or (mode == 3 and !input_check("confirm"))) 
				_fall_spd = -3;
		}
		else if !jump_input and _fall_spd < -0.5 
			_fall_spd = -0.5;
	
		move_x = lengthdir_x(move_input, _angle) - lengthdir_y(_fall_spd, _angle);
		move_y = lengthdir_x(move_input, _angle + 90) - lengthdir_y(_fall_spd, _angle + 90);
	
		on_ground = _on_ground;
		on_ceil = _on_ceil;
		on_platform = _on_platform;
		fall_spd = _fall_spd;
		fall_grav = _fall_grav;
		image_angle = _angle;
			
		if moveable == true
		{
			x += move_x;
			y += move_y;
		}
	}
	
	if mode == SOUL_MODE.ORANGE // Orange
	{
		if (Battle_GetState() == 2 && moveable)
		{
			if !(global.timer % 5)
			{
				part_type_color1(p, image_blend);
				part_type_scale(p, image_xscale, image_yscale);
				part_particles_create(ps, x, y, p, 1);
			}
			var input=[keyboard_check(vk_right),keyboard_check(vk_up),
						keyboard_check(vk_left),keyboard_check(vk_down)];
			if input[0] && input[1]			dir = 45;
			else if input[1] && input[2]	dir = 135;
			else if input[2] && input[3]	dir = 225;
			else if input[3] && input[0]	dir = -45;
			else if input[3]				dir = 270;
			else if input[2]			    dir = 180;
			else if input[1]			    dir = 90;
			else if input[0]			    dir = 0;
			x += lengthdir_x(move_spd, dir + image_angle);
			y += lengthdir_y(move_spd, dir + image_angle);
		}
	}
	
	if mode = SOUL_MODE.YELLOW
	{
		move_x = h_spd * move_spd;
		move_y = v_spd * move_spd;
		var _angle = image_angle;
		
		if moveable == true
		{
			x += lengthdir_x(move_x, _angle - 180);
			y += lengthdir_x(move_y, _angle - 180);
		}
		image_angle = _angle;
		
		if !timer
			if input_check_pressed("confirm")
				with(instance_create_depth(x, y, 0, yellow_bullet))
					image_angle = other.image_angle - 180;
	}
	
	if mode = SOUL_MODE.GREEN
	{
		x = board.x;
		y = board.y;
		var input = [input_check_pressed("right"), input_check_pressed("up"),
					input_check_pressed("left"), input_check_pressed("down")];
		var LastTarget = ShieldTargetAngle;
		for (var i = 0; i < 4; ++i)
			if input[i]	ShieldTargetAngle = i * 90;
		
		if LastTarget > 180 and ShieldTargetAngle == 0			ShieldDrawAngle -= 360;
		if LastTarget < -5 and ShieldTargetAngle == 90			ShieldDrawAngle += 360;
		if LastTarget < 90 and ShieldTargetAngle == 270		ShieldDrawAngle += 360;
		
		ShieldDrawAngle = lerp(ShieldDrawAngle, ShieldTargetAngle, 0.24);
		if ShieldIndex > 0 ShieldIndex -= 1/5;
	}
	
	if check_board
	{
		var _dist = point_distance(board_x, board_y, x, y);
		var _dir = point_direction(board_x, board_y, x, y);
		var r_x = clamp(lengthdir_x(_dist, _dir - board_angle) + board_x, board_left_limit, board_right_limit);
		var r_y = clamp(lengthdir_y(_dist, _dir - board_angle) + board_y, board_top_limit, board_bottom_limit);
		
			_dist = point_distance(board_x, board_y, r_x, r_y);
			_dir = point_direction(board_x, board_y, r_x, r_y);
		
		x = lengthdir_x(_dist, _dir + board_angle) + board_x;
		y = lengthdir_y(_dist, _dir + board_angle) + board_y;
	}
}

