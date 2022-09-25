///@desc Creates a Green Soul Arrow with given params
///@param {real} time	The time (in frames) taken for the arrow to reach the soul
///@param {real} speed	The speed of the arrow
///@param {real} direction	The direction of the Arrow
///@param {real} mode	The mode of the arrow (0 - Normal, 1 - Flip sides, 2 - Diagonal, 3 - Diagonal Flip)
function Bullet_Arrow(time, spd, dir, mode = 0)
{
	if (dir % 90) dir *= 90;
	dir %= 360
	var arrow = instance_create_depth(0, 0, obj_battle_board.depth - 1, obj_GreenArrow)
	with(arrow)
	{
		spd = spd;
		mode = mode;
		dir = dir;
		if mode == 1 or mode == 3
			dir -= 180;
		len = time * spd;
	}
	return arrow;}