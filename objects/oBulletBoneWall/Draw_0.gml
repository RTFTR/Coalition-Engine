if active
{
	var sprite = object,
		index = 2,
		spacing = sprite_get_height(object),
		head = cone;
	if head == 2
	{
		index = 4;
		spacing -= 2;
	}
	//Color
	var color, color_outline;
	switch type
	{
		case 0: color = c_white;	break;
		case 1: color = c_aqua;		break;
		case 2: color = c_orange;	break;
	}
	color_outline = color;
	
	var board = target_board,
		board_x = board.x,
		board_y = board.y,
		board_u = board_y - board.up,
		board_d = board_y + board.down,
		board_l = board_x - board.left,
		board_r = board_x + board.right;

	if time_warn
	{
		time_warn--;
		//Set corner locations
		var x1 = 0, y1 = 0, x2 = 0, y2 = 0;
		if dir == DIR.UP or dir == DIR.DOWN
		{
			x1 = board_l + 2;
			x2 = board_r - 3;
			y1 = dir == DIR.UP ? board_u + 2 : board_d - 2;
			y2 = dir == DIR.UP ? board_u + height - 2 - 5 : board_d - height + 5;
		}
		if dir == DIR.LEFT or dir == DIR.RIGHT
		{
			y1 = board_u + 2;
			y2 = board_d - 3;
			x1 = dir == DIR.LEFT ? board_l + 2 : board_r - 2;
			x2 = dir == DIR.LEFT ? board_l + height - 2 + 5 : board_r - height - 5;
		}
			
		draw_set_alpha(warn_alpha_filled);
		draw_set_color(warn_color);
		//Warning rectangle
		draw_rectangle(x1, y1, x2, y2, false);
		draw_set_alpha(1);
		//Warning outline
		draw_rectangle(x1, y1, x2, y2, true);
	}
	else	//Draw bones
	{
		var pos = [0, 0],
			_angle = 0,
			_x = x,
			_y = y,
			_dir = dir,
			_height = height,
			_alpha = 1,
			_type = type;
			
		Battle_Masking_Start(true);
			
		if _dir == DIR.UP or _dir == DIR.DOWN
		{
			pos[0] = _dir == DIR.UP ? _y - _height / 14 - 6 : _y - _height + 6;
			pos[1] = _dir != DIR.UP ? _y + _height / 14 + 6 : _y + _height - 6;
			_angle = dir == DIR.UP ? -90 : 90;
			var tar_y = mean(pos[0], pos[1]), tar_scale = (_height + 12) / 14;
			for (var i = board_l - spacing; i < board_r + spacing; i += spacing)
			{
				draw_sprite_ext(sprite, index, i, tar_y, tar_scale, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, i, tar_y, tar_scale, 1, _angle, color_outline, _alpha);
			}
			//Check collision
			if collision_rectangle(board_l, pos[0] + 2, board_r, pos[1] - 2, BattleSoulList[TargetBoard], false, true)
			{
				var collision = true;
				if type != 0 and type != 3
				{
					collision = IsSoulMoving();
					collision = (type == 1 ? collision : !collision);
				}
				if collision Soul_Hurt(damage);
			}
			// Hitbox
			if global.show_hitbox
			{
				draw_set_color(c_red)
				draw_rectangle(board_l, pos[0] + 2, board_r, pos[1] - 2, false)
			}
		}
		
		if _dir == DIR.LEFT or _dir == DIR.RIGHT
		{
			pos[0] = dir == DIR.LEFT ? _x - _height / 14 + 6 : _x - _height + 6;
			pos[1] = dir != DIR.LEFT ? _x + _height / 14 - 6 : _x + _height - 6;
			_angle = dir == DIR.LEFT ? 0 : 180;
			var tar_x = mean(pos[0], pos[1]), tar_scale = (_height + 12) / 14;
			for (var i = board_u - spacing; i < board_d + spacing; i += spacing)
			{
				draw_sprite_ext(sprite, index, tar_x, i, tar_scale, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, tar_x, i, tar_scale, 1, _angle, color_outline, _alpha);
			}
			//Collision
			if collision_rectangle(pos[0] - 10, board_u - 10, pos[1] + 10, board_d + 10, oSoul, false, true)
			{
				var collision = true;
				if type != 0 and type != 3
				{
					collision = IsSoulMoving();
					collision = (type == 1 ? collision : !collision);
				}
				if collision Soul_Hurt(damage);
			}
			// Hitbox
			if global.show_hitbox
			{
				draw_set_color(c_red);
				draw_rectangle(pos[0] - 10, board_u - 10, pos[1] + 10, board_d + 10, false);
			}
		}
		Battle_Masking_End();
			
		if state == 1 state = 2;
	}
}
