if active
{
	var sprite = spr_bone;
	var index = 2;
	var spacing = 10;
	var head = cone;
	if head == 2 { index = 4; spacing = 8; }
	var color = c_white;
	var color_outline = c_white//c_lime;
	if type == 1 color = c_aqua;
	if type == 2 color = c_orange;
	
	var board = obj_battle_board;
	var board_x = board.x;
	var board_y = board.y;
	var board_margin = [board.up, board.down, board.left, board.right];	
	
	var board_u = board_y - board_margin[0];
	var board_d = board_y + board_margin[1]; 
	var board_l = board_x - board_margin[2]; 
	var board_r = board_x + board_margin[3]; 

	if time_warn
	{
		time_warn--;
			
		var x1 = 0;
		var y1 = 0;
		var x2 = 0;
		var y2 = 0;
			
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
		var pos = [0, 0];
		var _angle = 0;
		var _x = x;
		var _y = y;
		var _dir = dir;
		var _height = height;
		var _alpha = 1//image_alpha;
		var _type = type;
			
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
				draw_sprite_ext(sprite, index, i, ((pos[0] + pos[1]) * 0.5), (_height + 12) / 14, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, i, ((pos[0] + pos[1]) * 0.5), (_height + 12) / 14, 1, _angle, color_outline, _alpha);
			}
			
			if collision_rectangle(board_l, pos[0] + 2, board_r, pos[1] - 2, obj_battle_soul, false, true)
			{
				var collision = true;
				if _type != 0 and _type != 3
				{
					collision = (floor(obj_battle_soul.x) != floor(obj_battle_soul.xprevious) 
							  or floor(obj_battle_soul.y) != floor(obj_battle_soul.yprevious));
					collision = (_type == 1 ? collision : !collision);
				}
				if collision Soul_Hurt();
			}
			
			// Hitbox
			if global.show_hitbox
			{
				//draw_set_alpha(0.5)
				draw_set_color(c_yellow)
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
				draw_sprite_ext(sprite, index, ((pos[0] + pos[1]) * 0.5), i, (_height + 12) / 14, 1, _angle, color, _alpha);
				draw_sprite_ext(sprite, index + 1, ((pos[0] + pos[1]) * 0.5), i, (_height + 12) / 14, 1, _angle, color_outline, _alpha);
			}
			if collision_rectangle(pos[0] + 4, board_u, pos[1] - 5, board_d, obj_battle_soul, false, true)
			{
				var collision = true;
				if _type != 0 and _type != 3
				{
					collision = (floor(obj_battle_soul.x) != floor(obj_battle_soul.xprevious) 
							  or floor(obj_battle_soul.y) != floor(obj_battle_soul.yprevious));
					collision = (_type == 1 ? collision : !collision);
				}
				if collision Soul_Hurt();
			}
			
			// Hitbox
			//draw_set_alpha(0.5)
			//draw_set_color(c_yellow)
			//draw_rectangle(pos[0] + 4, board_u, pos[1] - 5, board_d, false)
			
		}
			
		Battle_Masking_End();
			
		if state == 1 state = 2;
	}
	
}	
if state == 2
{
	if !timer
	{
		audio_stop_sound(snd_bonewall);
		audio_play_sound(snd_bonewall, 50, false);
	}
	else
	{
		if timer < time_move
		{
			var spd = floor((height) / time_move) 
		
			if dir == DIR.UP y += spd;
		    if dir == DIR.DOWN y -= spd;
			if dir == DIR.LEFT x += spd;
			if dir == DIR.RIGHT x -= spd;
		}
		if (timer >= time_move and timer <= time_move + time_stay)
		{
			if dir == DIR.UP
			{
				x = target_x;
				y = target_y + height;
			}
		    if dir == DIR.DOWN
			{
				x = target_x;
				y = target_y - height;
			}
			if dir == DIR.LEFT
			{
				x = target_x + height; 
				y = target_y;
			}
			if dir == DIR.RIGHT
			{
				x = target_x - height; 
				y = target_y;
			}
		}
		if timer > time_move + time_stay
		{
			var spd = floor(height / time_move);
			var kill_check = false
		
			if dir == DIR.UP
		    {
		        y -= spd
		        kill_check = y < target_y;
		    }
		    if dir == DIR.DOWN
		    {
		        y += spd
		        kill_check = y > target_y;
		    }
			if dir == DIR.LEFT
		    {
		        x -= spd
		        kill_check = x < target_x;
		    }
		    if dir == DIR.RIGHT
		    {
		        x += spd
		        kill_check = x > target_x;
		    }
	        
			if kill_check instance_destroy()
		}
	}
	timer++;
}
	

