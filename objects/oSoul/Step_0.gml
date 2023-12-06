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
	var h_spd = CHECK_HORIZONTAL,
		v_spd = CHECK_VERTICAL,
		
		move_spd = global.spd / (input_check("cancel") + 1),
		
		x_offset = sprite_width / 2,
		y_offset = sprite_height / 2,
		
		check_board = instance_exists(oBoard);
	if check_board // When the board is real XD
	{
		var board = BattleBoardList[min(SoulListID, array_length(BattleBoardList) - 1)],
			board_x			= board.x,
			board_y			= board.y,
			board_angle		= posmod(board.image_angle, 360),
			board_dir		= board_angle div 90,
			board_top_limit		= board_y - board.up + y_offset,
			board_bottom_limit	= board_y + board.down - y_offset,
			board_left_limit	= board_x - board.left + x_offset,
			board_right_limit	= board_x + board.right - x_offset;
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
			dir %= 360;
			image_angle = (dir + 90) % 360;

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

				platform_check[1] = [y_offset + 1, y_offset];

				jump_input = input_check("up");
				move_input = h_spd * move_spd;
			}
			if _angle == 180 {
				if check_board {
					_on_ground = r_y <= board_top_limit + 0.1;
					_on_ceil = r_y >= board_bottom_limit - 0.1;
				}

				platform_check[1] = [-10, -y_offset];
				

				jump_input = input_check("down");
				move_input = h_spd * -move_spd;
			}
			if _angle == 90 {
				if check_board {
					_on_ground = r_x >= board_right_limit - 0.1;
					_on_ceil = r_x <= board_left_limit + 0.1;
				}

				platform_check[0] = [x_offset + 1, -x_offset];

				jump_input = input_check("left");
				move_input = v_spd * -move_spd;
			}
			if _angle == 270 {
				if check_board {
					_on_ground = r_x <= board_left_limit + 0.1;
					_on_ceil = r_x >= board_right_limit - 0.1;
				}

				platform_check[0] = [-10, x_offset];

				jump_input = input_check("right");
				move_input = v_spd * move_spd;
			}

			if !check_board {
				_on_ground = false;
				_on_ceil = false;
			}
		
			//Platform checking
			var RelativePositionX = x + platform_check[0, 0],
				RelativePositionY = y + platform_check[1, 0],
				RespecitvePlatform = instance_position(RelativePositionX, RelativePositionY, oPlatform);
			
			if position_meeting(RelativePositionX, RelativePositionY, oPlatform) and _fall_spd >= 0 {
				_on_platform = true;
				while position_meeting(x + platform_check[0, 1], y + platform_check[1, 1], oPlatform) {
					with RespecitvePlatform {
						other.x += dsin(image_angle) / 10;
						other.y -= dcos(image_angle) / 10;
					}
				}
			}
			with RespecitvePlatform {
				if sticky {
					other.x += hspeed;
					other.y += vspeed;
				}
			}
			//Slamming
			if _on_ground or _on_platform or (_fall_spd < 0 and _on_ceil) {
				if slam {
					slam = false;
					Camera.Shake(global.slam_power / 2);
					if global.slam_damage {
						global.hp = global.hp > 1 ? global.hp-- : 1;
					}
					
					audio_play(snd_impact, true);
				}

				_fall_spd = (_on_ground or _on_platform) and jump_input ? -3 : 0;
			}
			else if !jump_input and _fall_spd < -0.5
				_fall_spd = -0.5;

			move_x = move_input * dcos(_angle) +  _fall_spd * dsin(_angle);
			move_y = move_input * -dsin(_angle) + _fall_spd * dcos(_angle);

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
				if !(global.timer % 5)
					//TrailStep(25);
					TrailEffect(25,,,,,,,, c_orange);
				//Movement
				dir = input_direction(dir, "left", "right", "up", "down",, true);
				var FinalAngle = dir + image_angle + draw_angle;
				x += move_spd * dcos(FinalAngle);
				y -= move_spd * dsin(FinalAngle);
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
			function AddShield(Input = [])
			{
				with oSoul
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
				with oSoul
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
					TopLine = oBoard.y - oBoard.up + 15,
					BottomLine = oBoard.y + oBoard.down - 15,
					YDifference = (BottomLine - TopLine) / (Purple.VLineAmount - 1);
				Purple.CurrentVLine += PRESS_VERTICAL;
				Purple.CurrentVLine = clamp(Purple.CurrentVLine, 0, Purple.VLineAmount - 1);
				Purple.YTarget = TopLine + Purple.CurrentVLine * YDifference;
				y = lerp(y, Purple.YTarget, 0.3);
			}
			else
			{
				BasicMovement(false, true);
				var NowLine = Purple.CurrentHLine,
					LeftLine = oBoard.x - oBoard.left + 15,
					RightLine = oBoard.x + oBoard.right - 15,
					XDifference = (RightLine - LeftLine) / (Purple.HLineAmount - 1);
				Purple.CurrentHLine += PRESS_HORIZONTAL;
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
		if check_board && !board.VertexMode {
			var _dist = point_distance(board_x, board_y, x, y),
				_dir = point_direction(board_x, board_y, x, y),
				r_x = clamp(lengthdir_x(_dist, _dir - board_angle) + board_x, board_left_limit, board_right_limit),
				r_y = clamp(lengthdir_y(_dist, _dir - board_angle) + board_y, board_top_limit, board_bottom_limit);

			_dist = point_distance(board_x, board_y, r_x, r_y);
			_dir = point_direction(board_x, board_y, r_x, r_y);

			x = lengthdir_x(_dist, _dir + board_angle) + board_x;
			y = lengthdir_y(_dist, _dir + board_angle) + board_y;
			
			//BoardClampSoul();
			
		}
		else
		{
			
		}
	
		//Check if the soul is allowed to go outside the screen
		if !allow_outside {
			x = clamp(x, oGlobal.MainCamera.x + x_offset, oGlobal.MainCamera.x + 640 - x_offset);
			y = clamp(y, oGlobal.MainCamera.y + y_offset, oGlobal.MainCamera.y + 480 - y_offset);
		}
	}
	
}

if global.EnableGrazing
{
	if !instance_exists(oGrazer)
		instance_create_depth(x, y, depth, oGrazer);
	oGrazer.x = x;
	oGrazer.y = y;
}

//Grazing (Unused, unless a better method is found)
//if global.EnableGrazing
//{
//	if !IsGrazer
//	{
//		if Grazer == -1
//		{
//			GrazeObj = instance_create_depth(x, y, depth, oSoul)
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