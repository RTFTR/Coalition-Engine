// Invincibility
if global.inv > 0 {
	global.inv--;
	if !global.kr_activation {
		if image_speed == 0 {
			image_speed = 1 / 2;
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
var STATE = oBattleController.battle_state;

if STATE == 2 {
	var h_spd = input_check("right") - input_check("left"),
		v_spd = input_check("down") - input_check("up"),
		
		move_spd = global.spd / (input_check("cancel") + 1),
		
		x_offset = sprite_width / 2,
		y_offset = sprite_height / 2,
		
		check_board = instance_exists(oBoard);
	if check_board // When the board is real XD
	{
		var board = oBoard;
		var board_x = board.x;
		var board_y = board.y;
		var board_angle = Posmod(board.image_angle, 360);
		var board_margin = [board.up, board.down, board.left, board.right];
		var board_dir = board_angle div 90

		var board_limit_template = [
			(board_y - board_margin[0]) + y_offset,
			(board_y + board_margin[1]) - y_offset,
			(board_x - board_margin[2]) + x_offset,
			(board_x + board_margin[3]) - x_offset
		]
		var board_top_limit = board_limit_template[0];
		var board_bottom_limit = board_limit_template[1];
		var board_left_limit = board_limit_template[2];
		var board_right_limit = board_limit_template[3];
	}

	//Check if soul follows the movement of the board
	if follow_board {
		x += board_x - oBoard.xprevious;
		y += board_y - oBoard.yprevious;
	}

	switch mode
	{
		case SOUL_MODE.RED: {
			BasicMovement();
		break
		}

		case SOUL_MODE.BLUE : {
			if dir == DIR.DOWN image_angle = 0;
			else if dir == DIR.UP image_angle = 180;
			else if dir == DIR.LEFT image_angle = 270;
			else if dir == DIR.RIGHT image_angle = 90;

			var _on_ground = false,
				_on_ceil = false,
				_on_platform = false,
				_fall_spd = fall_spd,
				_fall_grav = fall_grav,

				_angle = image_angle,

				platform_check_x = [0, 0],
				platform_check_y = [0, 0];
		
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

				platform_check_x = [0, 0];
				platform_check_y = [y_offset + 1, y_offset];

				jump_input = input_check("up");
				move_input = h_spd * move_spd;
			}
			if _angle == 180 {
				if check_board {
					_on_ground = r_y <= board_top_limit + 0.1;
					_on_ceil = r_y >= board_bottom_limit - 0.1;
				}

				platform_check_x = [0, 0];
				platform_check_y = [y_offset - 1, -y_offset];

				jump_input = input_check("down");
				move_input = h_spd * -move_spd;
			}
			if _angle == 90 {
				if check_board {
					_on_ground = r_x >= board_right_limit - 0.1;
					_on_ceil = r_x <= board_left_limit + 0.1;
				}

				platform_check_x = [x_offset - 1, -x_offset];
				platform_check_y = [0, 0];

				jump_input = input_check("left");
				move_input = v_spd * -move_spd;
			}
			if _angle == 270 or _angle == -90 {
				if check_board {
					_on_ground = r_x <= board_left_limit + 0.1;
					_on_ceil = r_x >= board_right_limit - 0.1;
				}

				platform_check_x = [x_offset + 1, x_offset];
				platform_check_y = [0, 0];

				jump_input = input_check("right");
				move_input = v_spd * move_spd;
			}

			if !check_board {
				_on_ground = false;
				_on_ceil = false;
			}
		
			//Platform checking
			var platform_check = instance_position(x + platform_check_x[0], y + platform_check_y[0], oPlatform);

			if position_meeting(x + platform_check_x[0], y + platform_check_y[0], oPlatform) and _fall_spd >= 0 {
				_on_platform = true;
				while position_meeting(x + platform_check_x[1], y + platform_check_y[1], oPlatform) {
					with platform_check {
						other.x += lengthdir_x(0.1, image_angle + 90);
						other.y += lengthdir_y(0.1, image_angle + 90);
					}
				}
			}
			with platform_check {
				if platform_check.sticky {
					other.x += x - xprevious;
					other.y += y - yprevious;
				}
			}
			//Slamming
			if _on_ground or _on_platform or (_fall_spd < 0 and _on_ceil) {
				if slam {
					slam = false;
					Camera_Shake(global.slam_power / 2);
					if global.slam_damage {
						global.hp = global.hp > 1 ? global.hp-- : 1;
					}

					audio_stop_sound(snd_impact);
					audio_play_sound(snd_impact, 50, false);
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
				if !(global.timer % 5) TrailStep(25)
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
			x = board.x;
			y = board.y;
			var input = [input_check_pressed("right"), input_check_pressed("up"),
				input_check_pressed("left"), input_check_pressed("down")
			];
			var LastTarget = ShieldTargetAngle;
			for (var i = 0; i < 4; ++i)
				if input[i] ShieldTargetAngle = i * 90;
		
			//Smooth shield angle animation
			if LastTarget > 180 and ShieldTargetAngle == 0 ShieldDrawAngle -= 360;
			if LastTarget == 180 and ShieldTargetAngle == 0 ShieldDrawAngle = 180;
			if LastTarget < -5 and ShieldTargetAngle == 90 ShieldDrawAngle += 360;
			if LastTarget < 90 and ShieldTargetAngle == 270 ShieldDrawAngle += 360;
		
			//Shield angle lerping
			ShieldDrawAngle = lerp(ShieldDrawAngle, ShieldTargetAngle, 0.24);
			if abs(ShieldTargetAngle - ShieldDrawAngle) <= 0.1
			ShieldDrawAngle = ShieldTargetAngle;
			if ShieldIndex > 0 ShieldIndex -= 1 / 5;
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
				var NowLine = Purple.CurrentVLine;
				var TopLine = oBoard.y - oBoard.up + 15;
				var BottomLine = oBoard.y + oBoard.down - 15;
				var YDifference = (BottomLine - TopLine) / (Purple.VLineAmount - 1);
				Purple.CurrentVLine += input_check_pressed("down") - input_check_pressed("up");
				Purple.CurrentVLine = clamp(Purple.CurrentVLine, 0, Purple.VLineAmount - 1);
				Purple.YTarget = TopLine + Purple.CurrentVLine * YDifference;
				y = lerp(y, Purple.YTarget, 0.3);
			}
			else
			{
				BasicMovement(false, true);
				var NowLine = Purple.CurrentHLine;
				var LeftLine = oBoard.x - oBoard.left + 15;
				var RightLine = oBoard.x + oBoard.right - 15;
				var XDifference = (RightLine - LeftLine) / (Purple.HLineAmount - 1);
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
			var _dist = point_distance(board_x, board_y, x, y);
			var _dir = point_direction(board_x, board_y, x, y);
			var r_x = clamp(lengthdir_x(_dist, _dir - board_angle) + board_x, board_left_limit, board_right_limit);
			var r_y = clamp(lengthdir_y(_dist, _dir - board_angle) + board_y, board_top_limit, board_bottom_limit);

			_dist = point_distance(board_x, board_y, r_x, r_y);
			_dir = point_direction(board_x, board_y, r_x, r_y);

			x = lengthdir_x(_dist, _dir + board_angle) + board_x;
			y = lengthdir_y(_dist, _dir + board_angle) + board_y;
		}
	
		//Collision check of the Cover Board
		if instance_exists(oBoardCover) {
			//Old Collision Checker
			for (var i = 0, n = instance_number(oBoardCover); i < n; i++) {
				var board_cover = instance_find(oBoardCover, i);
				with board_cover {
					var board_cover_angle = Posmod(image_angle, 360);
					var board_cover_margin = [up, down, left, right];
					var board_cover_dir = board_cover_angle div 90
					var board_cover_limit_template = [];

					board_cover_limit_template = [
						y - board_cover_margin[0] - 1,
						y + board_cover_margin[1],
						x - board_cover_margin[2] - x_offset + 1,
						x + board_cover_margin[3] - 3
					]
					var board_cover_top_limit = board_cover_limit_template[0];
					var board_cover_bottom_limit = board_cover_limit_template[1];
					var board_cover_left_limit = board_cover_limit_template[2];
					var board_cover_right_limit = board_cover_limit_template[3];
					var frame = lengthdir_x(board_cover.thickness_frame, board_cover_angle);
					var ldx = lengthdir_x(1, board_cover_angle);
					var ldy = lengthdir_y(1, board_cover_angle);
					var _dist = point_distance(x, y, other.x, other.y);
					var _dir = point_direction(x, y, other.x, other.y);
					var CurrentX = lengthdir_x(_dist, _dir - board_cover_angle) + x;
					var CurrentY = lengthdir_y(_dist, _dir - board_cover_angle) + y;
					r_x = abs(CurrentX - board_cover_left_limit) <= abs(CurrentX - board_cover_right_limit) ?
						board_cover_left_limit - x_offset - frame : board_cover_right_limit + x_offset + frame*3/5;
					r_y = abs(CurrentY - board_cover_top_limit) <= abs(CurrentY - board_cover_bottom_limit) ?
						board_cover_top_limit - y_offset - frame : board_cover_bottom_limit + y_offset + frame;

					_dist = point_distance(x, y, r_x, r_y);
					_dir = point_direction(x, y, r_x, r_y);

					if board_cover.contains_soul {
						if abs(x - other.x) >= abs(y - other.y)
							other.x = lengthdir_x(_dist, _dir + board_cover_angle) + x;
						else other.y = lengthdir_y(_dist, _dir + board_cover_angle) + y;
					}
				}
			}
		}
		//Check if the soul is allowed to go outside the screen
		if !allow_outside {
			x = clamp(x, oGlobal.camera_x + x_offset, oGlobal.camera_x + 640 - x_offset);
			y = clamp(y, oGlobal.camera_y + y_offset, oGlobal.camera_y + 480 - y_offset);
		}
	}
	
}

//Grazing
if global.EnableGrazing
{
	if !IsGrazer
	{
		if Grazer == -1
		{
			GrazeObj = instance_create_depth(x, y, depth, oSoul)
			Grazer = 1;
		}
		with GrazeObj
		{
			IsGrazer = true;
			x = x;
			y = y;
			image_xscale = 4;
			image_yscale = 4;
			image_alpha = 0;
		}
		if Grazer
		{
			GrazeObj.x = x;
			GrazeObj.y = y;
		}
	}
}