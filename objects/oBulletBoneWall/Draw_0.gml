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
	var color = c_white,
		color_outline = c_white;
	if type == 1 color = c_aqua;
	if type == 2 color = c_orange;
	
	var board = oBoard,
		board_x = board.x,
		board_y = board.y,
		board_margin = [board.up, board.down, board.left, board.right],
		board_u = board_y - board_margin[0],
		board_d = board_y + board_margin[1],
		board_l = board_x - board_margin[2],
		board_r = board_x + board_margin[3];

	if time_warn
	{
		time_warn--;
			
		var x1 = 0,
			y1 = 0,
			x2 = 0,
			y2 = 0;
			
		if dir == DIR.UP or dir == DIR.DOWN
		{
			x1 = board_l + 2;
			x2 = board_r - 3;
				
			if dir == DIR.UP
			{
				y1 = board_u + 2;
				y2 = board_u + height - 2;
			}
			if dir == DIR.DOWN
			{
				y1 = board_d - 2;
				y2 = board_d - height;
			}
		}
		if dir == DIR.LEFT or dir == DIR.RIGHT
		{
			y1 = board_u + 2;
			y2 = board_d - 3;
				
			if dir == DIR.LEFT
			{
				x1 = board_l + 2;
				x2 = board_l + height - 2;
			}
			if dir == DIR.RIGHT
			{
				x1 = board_r - 2;
				x2 = board_r - height;
			}
		}
			
		draw_set_alpha(warn_alpha_filled);
		draw_set_color(warn_color);
		draw_rectangle(x1, y1, x2, y2, false);
			
		draw_set_alpha(1);
		draw_set_color(warn_color);
		draw_rectangle(x1, y1, x2, y2, true);
	}
	else
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
			if _dir == DIR.DOWN 
			{
				pos = [(_y - _height) + 6, (_y + (_height / 14)) + 6]; 
				_angle = 90;
			}
			if _dir == DIR.UP   
			{
				pos = [(_y - (_height / 14)) - 6, (_y + _height) - 6]; 
				_angle = -90;
			}
			for (var i = board_l - spacing; i < board_r + spacing; i += spacing)
			{
				draw_sprite_ext(sprite, index, i, ((pos[0] + pos[1]) / 2), (_height + 12) / 14, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, i, ((pos[0] + pos[1]) / 2), (_height + 12) / 14, 1, _angle, color_outline, _alpha);
			}
			if collision_rectangle(board_l, pos[0] + 2, board_r, pos[1] - 2, oSoul, false, true)
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
			if _dir == DIR.LEFT  
			{
				pos = [(_x - (_height / 14)) + 6, (_x + _height) - 6]; 
				_angle = 0;
			}
			if _dir == DIR.RIGHT 
			{
				pos = [(_x - _height) + 6, (_x + (_height / 14)) - 6];	
				_angle = 180
			}
			
			for (var i = board_u - spacing; i < board_d + spacing; i += spacing)
			{
				draw_sprite_ext(sprite, index, ((pos[0] + pos[1]) / 2), i, (_height + 12) / 14, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, ((pos[0] + pos[1]) / 2), i, (_height + 12) / 14, 1, _angle, color_outline, _alpha);
			}
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
				draw_set_color(c_red)
				draw_rectangle(pos[0] - 10, board_u - 10, pos[1] + 10, board_d + 10, false)
			}
		}
			
		Battle_Masking_End();
			
		if state == 1 state = 2;
	}
	
}	
if state == 2
{
	if !timer and sound_create
	{
		audio_stop_sound(snd_bonewall);
		audio_play_sound(snd_bonewall, 50, false);
	}
	else
	{
		if timer < time_move
		{
			var spd = floor((height) / time_move);
			
			x -= lengthdir_x(spd, dir);
			y -= lengthdir_y(spd, dir);
		}
		if (timer >= time_move and timer <= time_move + time_stay)
		{
			x = target_x - lengthdir_x(height, dir);
			y = target_y - lengthdir_y(height, dir);
		}
		if timer > time_move + time_stay
		{
			var spd = floor(height / time_move),
				kill_check = false;
			
			x += lengthdir_x(spd, dir);
			y += lengthdir_y(spd, dir);
			switch dir
			{
				case DIR.UP:
		        kill_check = y < target_y;
				break
				case DIR.DOWN:
		        kill_check = y > target_y;
				break
				case DIR.LEFT:
		        kill_check = x < target_x;
				break
				case DIR.RIGHT:
		        kill_check = x > target_x;
				break
			}
			if kill_check instance_destroy();
		}
	}
	timer++;
}
	

