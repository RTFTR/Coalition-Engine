function len_load()
{
	len = 0;
	len_x = 0;
	len_y = 0;
	lenable = false;
	len_angle = false;
	len_angle_extra = 0;
	len_dir = 0;
	len_speed = 0;
	len_dir_move = 0;
	len_target = noone;
	len_hspeed = 0;
	len_vspeed = 0;
}

function len_step()
{
	if lenable
	{
		if len_target != noone
			if instance_exists(len_target)
			{
				len_x = len_target.x;
				len_y = len_target.y;
			}
		len_x += len_hspeed;
		len_y += len_vspeed;
	    len_dir += len_dir_move;
	    len += len_speed;
	    x = len_x + len * dcos(len_dir);  
	    y = len_y + len * -dsin(len_dir);
	    if len_angle image_angle += len_dir_move;
	}
}

function axis_load()
{
	axis = 0;
	axis_x = x;
	axis_y = y;
	axis_angle = 0;
	axis_override = false;
	axis_override_angle = 0;
}

function axis_step()
{
	if axis
	{
		var board = oBoard,
			_ang = axis_override ? axis_override_angle : board.image_angle;
		axis_x += hspeed;
		axis_y += vspeed;
		var dis = point_distance(board.x, board.y, axis_x, axis_y),
			dir = point_direction(board.x, board.y, axis_x, axis_y);
		x = dis * dcos(dir + _ang) + board.x;
		y = dis * -dsin(dir + _ang) + board.y;
		axis_angle = _ang;
	}
}