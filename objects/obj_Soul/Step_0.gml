// Invincibility
if global.inv > 0 {
	global.inv--;
	if !global.kr_activation {
		if image_speed == 0 {
			image_speed = 1/2;
			image_index = 1;
		}
	}
}
else {
	if image_speed != 0 and sprite_index != sprSoulFlee {
		image_speed = 0;
		image_index = 0;
	}
}

// Mode
var STATE = obj_BattleController.battle_state;

if STATE == 2 {
	var h_spd = input_check("right") - input_check("left"),
		v_spd = input_check("down") - input_check("up"),
		
		move_spd = global.spd / (input_check("cancel") + 1),
		
		x_offset = sprite_width / 2,
		y_offset = sprite_height / 2,
		
		check_board = instance_exists(obj_Board);
	if check_board // When the board is real XD
	{
		var board = obj_Board,
			board_x			= board.x,
			board_y			= board.y,
			board_angle		= posmod(board.image_angle, 360),
			board_margin	= [board.up, board.down, board.left, board.right],
			board_dir		= board_angle div 90,
			
			board_limit_template = [
				board_y - board_margin[0] + y_offset,
				board_y + board_margin[1] - y_offset,
				board_x - board_margin[2] + x_offset,
				board_x + board_margin[3] - x_offset
			],
			board_top_limit		= board_limit_template[0],
			board_bottom_limit	= board_limit_template[1],
			board_left_limit	= board_limit_template[2],
			board_right_limit	= board_limit_template[3];
	}

	//Check if soul follows the movement of the board
	if follow_board {
		x += board_x - obj_Board.xprevious;
		y += board_y - obj_Board.yprevious;
	}

	switch mode
	{
		case SOUL_MODE.RED: {
			BasicMovement();
		break
		}

		case SOUL_MODE.BLUE : {
			dir %= 360;
			image_angle = dir + 90;
			image_angle %= 360;

			var _on_ground = false,
				_on_ceil = false,
				_on_platform = false,
				_fall_spd = fall_spd,
				_fall_grav = fall_grav,

				_angle = image_angle,

				platform_check = [[0, 0], [0, 0]];
		
			//Soul Gravity
			if _fall_spd < 4 and _fall_spd > 0.25 _fall_grav = 0.15;
			if _fall_spd <= 0.25 and _fall_spd > -0.5 _fall_grav = 0.05;
			if _fall_spd <= -0.5 and _fall_spd > -2 _fall_grav = 0.125;
			if _fall_spd <= -2 _fall_grav = 0.05;

			_fall_spd += _fall_grav;

			var _dist = point_distance(board_x, board_y, x, y),
				_dir = point_direction(board_x, board_y, x, y),
				r_x = lengthdir_x(_dist, _dir - board_dir) + board_x,
				r_y = lengthdir_y(_dist, _dir - board_dir) + board_y;
			//Input and collision check of different directions of soul
			if _angle == 0 {
				if check_board {
					_on_ground = r_y >= board_bottom_limit - 0.1;
					_on_ceil = r_y <= board_top_limit + 0.1;
				}

				platform_check = [[0, 0], [y_offset + 1, y_offset]];

				jump_input = input_check("up");
				move_input = h_spd * move_spd;
			}
			if _angle == 180 {
				if check_board {
					_on_ground = r_y <= board_top_limit + 0.1;
					_on_ceil = r_y >= board_bottom_limit - 0.1;
				}

				platform_check = [[0, 0], [y_offset - 1, -y_offset]];
				

				jump_input = input_check("down");
				move_input = h_spd * -move_spd;
			}
			if _angle == 90 {
				if check_board {
					_on_ground = r_x >= board_right_limit - 0.1;
					_on_ceil = r_x <= board_left_limit + 0.1;
				}

				platform_check = [[x_offset - 1, -x_offset], [0, 0]];

				jump_input = input_check("left");
				move_input = v_spd * -move_spd;
			}
			if _angle == 270 or _angle == -90 {
				if check_board {
					_on_ground = r_x <= board_left_limit + 0.1;
					_on_ceil = r_x >= board_right_limit - 0.1;
				}

				platform_check = [[x_offset + 1, x_offset], [0, 0]];

				jump_input = input_check("right");
				move_input = v_spd * move_spd;
			}

			if !check_board {
				_on_ground = false;
				_on_ceil = false;
			}
		
			//Platform checking
			var RespecitvePlatform = instance_position(x + platform_check[0, 0], y + platform_check[1, 0], obj_Platform);

			if position_meeting(x + platform_check[0, 0], y + platform_check[1, 0], obj_Platform) and _fall_spd >= 0 {
				_on_platform = true;
				while position_meeting(x + platform_check[0, 1], y + platform_check[1, 1], obj_Platform) {
					with RespecitvePlatform {
						other.x += lengthdir_x(0.1, image_angle + 90);
						other.y += lengthdir_y(0.1, image_angle + 90);
					}
				}
			}
			with RespecitvePlatform {
				if RespecitvePlatform.sticky {
					other.x += x - xprevious;
					other.y += y - yprevious;
				}
			}
			//Slamming
			if _on_ground or _on_platform or (_fall_spd < 0 and _on_ceil) {
				if slam {
					slam = false;
					camera_shake(global.slam_power / 2);
					if global.slam_damage {
						global.hp = global.hp > 1 ? global.hp-- : 1;
					}
					
					audio_play(snd_impact, true);
				}

				_fall_spd = (_on_ground or _on_platform) and jump_input ? -3 : 0;
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

			if moveable {
				x += move_x;
				y += move_y;
			}
		break
		}

		case SOUL_MODE.ORANGE : {
			//Movement particle
			if moveable {
				if !(global.timer % 5) instance_trail_create(25);
				var input = [input_check("right"), input_check("up"),
					input_check("left"), input_check("down")
				];
				//Movement
					 if input[0] && input[1] dir = 45;
				else if input[1] && input[2] dir = 135;
				else if input[2] && input[3] dir = 225;
				else if input[3] && input[0] dir = -45;
				else if input[3] dir = 270;
				else if input[2] dir = 180;
				else if input[1] dir = 90;
				else if input[0] dir = 0;
				x += lengthdir_x(move_spd, dir + image_angle);
				y += lengthdir_y(move_spd, dir + image_angle);
			}
		break
		}

		case SOUL_MODE.YELLOW : {
			BasicMovement();
		
			//Shooting the bullet
			if !timer {
				if input_check_pressed("confirm") {
					instance_create_depth(x, y, 0, oYellowBullet,
					{
						image_angle : other.image_angle
					});
					//The delay until you can shoot the next bullet
					timer = 15;
				}
			}
			else timer--;
		break
		}

		case SOUL_MODE.GREEN : {
			function DestroyArrow(obj) {
				audio_play(snd_ding);
				ShieldAlpha[obj.mode] = 1;
				instance_destroy(obj);
			}
			///@param {Array} Input		The input keys of the shield
			function AddShield(Input = -1)
			{
				with obj_Soul
				{
					array_push(ShieldAlpha, 0);
					array_push(ShieldDrawAngle, 0);
					array_push(ShieldTargetAngle, 0);
					array_push(ShieldLen, 18);
					if Input != -1
						array_push(ShieldInput, Input);
					ShieldAmount++;
				}
			}
			function RemoveShield(num)
			{
				with obj_Soul
				{
					array_delete(ShieldAlpha, num, 1);
					array_delete(ShieldDrawAngle, num, 1);
					array_delete(ShieldTargetAngle, num, 1);
					array_delete(ShieldLen, num, 1);
					ShieldAmount--;
				}
			}
			x = board.x;
			y = board.y;
			for(var i = 0; i < ShieldAmount; i++)
			{
				var input = [
					keyboard_check_pressed(ShieldInput[i, 0]), keyboard_check_pressed(ShieldInput[i, 1]),
					keyboard_check_pressed(ShieldInput[i, 2]), keyboard_check_pressed(ShieldInput[i, 3])
				],
					LastTarget = ShieldTargetAngle[i];
				for (var ii = 0; ii < 4; ++ii)
					if input[ii] ShieldTargetAngle[i] = ii * 90;
		
				//Smooth shield angle animation
				if LastTarget > 180 and ShieldTargetAngle[i] == 0	ShieldDrawAngle[i] -= 360;
				if LastTarget == 180 and ShieldTargetAngle[i] == 0	ShieldDrawAngle[i] = 180;
				if LastTarget < -5 and ShieldTargetAngle[i] == 90	ShieldDrawAngle[i] += 360;
				if LastTarget < 90 and ShieldTargetAngle[i] == 270  ShieldDrawAngle[i] += 360;
		
				//Shield angle lerping
				ShieldDrawAngle[i] = lerp(ShieldDrawAngle[i], ShieldTargetAngle[i], 0.2);
				if abs(ShieldTargetAngle[i] - ShieldDrawAngle[i]) <= 0.1
					ShieldDrawAngle[i] = ShieldTargetAngle[i];
				if ShieldAlpha[i] > 0 ShieldAlpha[i] -= 1 / 30;
				
			}
		break
		}
		
		case SOUL_MODE.PURPLE : {
			if keyboard_check_pressed(vk_space)
			{
				Purple.Mode = !Purple.Mode;
				x = Purple.XTarget;
				y = Purple.YTarget;
				Purple.ForceAlpha = 1;
			}
			if !Purple.Mode
			{
				BasicMovement(true, false);
				var NowLine = Purple.CurrentVLine,
					TopLine = obj_Board.y - obj_Board.up + 15,
					BottomLine = obj_Board.y + obj_Board.down - 15,
					YDifference = (BottomLine - TopLine) / (Purple.VLineAmount - 1);
				Purple.CurrentVLine += input_check_pressed("down") - input_check_pressed("up");
				Purple.CurrentVLine = clamp(Purple.CurrentVLine, 0, Purple.VLineAmount - 1);
				Purple.YTarget = TopLine + Purple.CurrentVLine * YDifference;
				y = lerp(y, Purple.YTarget, 0.3);
			}
			else
			{
				BasicMovement(false, true);
				var NowLine = Purple.CurrentHLine,
					LeftLine = obj_Board.x - obj_Board.left + 15,
					RightLine = obj_Board.x + obj_Board.right - 15,
					XDifference = (RightLine - LeftLine) / (Purple.HLineAmount - 1);
				Purple.CurrentHLine += input_check_pressed("right") - input_check_pressed("left");
				Purple.CurrentHLine = clamp(Purple.CurrentHLine, 0, Purple.HLineAmount - 1);
				Purple.XTarget = LeftLine + Purple.CurrentHLine * XDifference;
				x = lerp(x, Purple.XTarget, 0.3);
			}
		break
		}
		
	}
	
	if !IsGrazer
	{
		//Collision check of the Main Board
		if check_board {
			var _dist = point_distance(board_x, board_y, x, y),
				_dir = point_direction(board_x, board_y, x, y),
				r_x = clamp(lengthdir_x(_dist, _dir - board_angle) + board_x, board_left_limit, board_right_limit),
				r_y = clamp(lengthdir_y(_dist, _dir - board_angle) + board_y, board_top_limit, board_bottom_limit);

			_dist = point_distance(board_x, board_y, r_x, r_y);
			_dir = point_direction(board_x, board_y, r_x, r_y);

			x = lengthdir_x(_dist, _dir + board_angle) + board_x;
			y = lengthdir_y(_dist, _dir + board_angle) + board_y;
		}
	
		//Collision check of the Cover Board
		//if instance_exists(obj_BoardCover) {
		//	//Old Collision Checker
		//	for (var i = 0, n = instance_number(obj_BoardCover); i < n; i++) {
		//		var board_cover = instance_find(obj_BoardCover, i);
		//		with board_cover {
		//			var board_cover_angle = posmod(image_angle, 360),
		//				board_cover_margin = [up, down, left, right],
		//				board_cover_dir = board_cover_angle div 90,
		//				board_cover_limit_template = [];

		//			board_cover_limit_template = [
		//				y - board_cover_margin[0] - 1,
		//				y + board_cover_margin[1],
		//				x - board_cover_margin[2] - x_offset + 1,
		//				x + board_cover_margin[3] - 3
		//			]
		//			var board_cover_top_limit = board_cover_limit_template[0],
		//				board_cover_bottom_limit = board_cover_limit_template[1],
		//				board_cover_left_limit = board_cover_limit_template[2],
		//				board_cover_right_limit = board_cover_limit_template[3],
		//				frame = lengthdir_x(board_cover.thickness_frame, board_cover_angle),
		//				ldx = lengthdir_x(1, board_cover_angle),
		//				ldy = lengthdir_y(1, board_cover_angle),
		//				_dist = point_distance(x, y, other.x, other.y),
		//				_dir = point_direction(x, y, other.x, other.y),
		//				CurrentX = lengthdir_x(_dist, _dir - board_cover_angle) + x,
		//				CurrentY = lengthdir_y(_dist, _dir - board_cover_angle) + y;
					
		//			r_x = abs(CurrentX - board_cover_left_limit) <= abs(CurrentX - board_cover_right_limit) ?
		//				board_cover_left_limit - x_offset - frame : board_cover_right_limit + x_offset + frame * 3 / 5;
		//			r_y = abs(CurrentY - board_cover_top_limit) <= abs(CurrentY - board_cover_bottom_limit) ?
		//				board_cover_top_limit - y_offset - frame : board_cover_bottom_limit + y_offset + frame;

		//			_dist = point_distance(x, y, r_x, r_y);
		//			_dir = point_direction(x, y, r_x, r_y);

		//			if board_cover.contains_soul {
		//				if abs(x - other.x) >= abs(y - other.y)
		//					other.x = lengthdir_x(_dist, _dir + board_cover_angle) + x;
		//				else other.y = lengthdir_y(_dist, _dir + board_cover_angle) + y;
		//			}
		//		}
		//	}
		//}
		//Check if the soul is allowed to go outside the screen
		if !allow_outside {
			x = clamp(x, obj_Global.camera_x + x_offset, obj_Global.camera_x + 640 - x_offset);
			y = clamp(y, obj_Global.camera_y + y_offset, obj_Global.camera_y + 480 - y_offset);
		}
	}
	
}

//if global.EnableGrazing
//{
//	if !instance_exists(oGrazer)
//		instance_create_depth(x, y, depth, oGrazer);
//	oGrazer.x = x;
//	oGrazer.y = y;
//}

//Grazing (Unused, unless a better method is found)
//if global.EnableGrazing
//{
//	if !IsGrazer
//	{
//		if Grazer == -1
//		{
//			GrazeObj = instance_create_depth(x, y, depth, obj_Soul)
//			Grazer = 1;
//		}
//		with GrazeObj
//		{
//			IsGrazer = true;
//			x = x;
//			y = y;
//			image_xscale = 4;
//			image_yscale = 4;
//			image_alpha = 0;
//		}
//		if Grazer
//		{
//			GrazeObj.x = x;
//			GrazeObj.y = y;
//		}
//	}
//}