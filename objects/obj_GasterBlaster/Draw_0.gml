var color = image_blend,
	_type = type;
if type = 1 color = c_aqua;
if type = 2 color = c_orange;
if type = 3 color = c_red;
Battle_Masking_Start(true);

if state = 4
{
	var _x = x,
		_y = y,
		
		_angle = image_angle,
		_alpha = beam_alpha,
		
		_xscale = image_xscale,
		_yscale = image_yscale,
		_end_point = e;
	
	var _blast_timer = timer_blast,
		_exit_timer = timer_exit,
		_size = beam_scale;
	
	var beam_siner = sin(_blast_timer / pi) * _size / 4;
	
	var rx = 0,
		ry = 0
	
	draw_set_alpha(_alpha);
	var pre_col = color;
	var cosx = dcos(image_angle);
	var sinx = -dsin(image_angle);
	draw_set_color(color);
	var xs = 35 * _xscale * cosx,
		ys = 35 * _xscale * sinx,
		xe = (1200 + _end_point) * cosx,
		ye = (1200 + _end_point) * sinx;
	
	draw_line_width(x + xs + rx, y + ys + ry, x + xe + rx, y + ye + ry, _size + beam_siner);
	
	var xa = 25 * _xscale * cosx,
		ya = 25 * _xscale * sinx,
		xb = 30 * _xscale * cosx,
		yb = 30 * _xscale * sinx;
	
	draw_line_width(x + xs + rx, y + ys + ry, x + xa + rx, y + ya + ry, (_size / 2) + beam_siner);
	draw_line_width(x + xs + rx, y + ys + ry, x + xb + rx, y + yb + ry, (_size / 1.25) + beam_siner);
	
	color = pre_col;
	var collisiondir_x = dcos(image_angle - 90),
		collisiondir_y = -dsin(image_angle - 90);
	if global.inv <= 0
	{
		for (var c = 0; c < _size / 2.25; c++)
		{
			var x_f = ((collisiondir_x * (_yscale + beam_siner)) / 2) * (c / 8),
				y_f = ((collisiondir_y * (_yscale + beam_siner)) / 2) * (c / 8);

			if beam_alpha >= 0.8
			{
				if collision_line((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) - y_f, obj_Soul, false, true)
				or collision_line((x + xs + rx) + x_f, (y + ys + ry) + y_f, (x + xe + rx) + x_f, (y + ye + ry) + y_f, obj_Soul, false, true)
				{
					var collision = true;
					if _type != 0 and _type != 3
					{
						collision = IsSoulMoving();
						collision = (_type == 1 ? collision : !collision);
					}
					if collision Soul_Hurt();
				
				}
				if global.show_hitbox
				{
					draw_set_color(c_red);
					draw_line_width((x + xs + rx) - x_f, (y + ys + ry) - y_f, (x + xe + rx) - x_f, (y + ye + ry) - y_f, 3);
					draw_line_width((x + xs + rx) + x_f, (y + ys + ry) + y_f, (x + xe + rx) + x_f, (y + ye + ry) + y_f, 3);
				}
			}
		}
	}
	
	auto_destroy();
	
	x = _x;
	y = _y;
	image_angle = _angle;
	beam_alpha = _alpha;
	
	image_xscale = _xscale;
	image_yscale = _yscale;
	image_blend = color;
	
	timer_blast = _blast_timer;
	timer_exit = _exit_timer;
	beam_scale = _size;
	e = _end_point;
}

draw_set_alpha(1);
draw_self()
draw_set_color(c_white);
Battle_Masking_End();

