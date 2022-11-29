///@desc Creates a Green Soul Arrow with given params
///@param {real} time	The time (in frames) taken for the arrow to reach the soul
///@param {real} speed	The speed of the arrow
///@param {real} direction	The direction of the Arrow
///@param {real} mode	The mode of the arrow (Macros provided by ARROW_MODE)
function Bullet_Arrow(Time, Spd, Dir, Mode = 0)
{
	Dir *= 90;
	var arrow = instance_create_depth(0, 0, -2, oGreenArr)
	with(arrow)
	{
		spd = Spd;
		mode = Mode;
		dir = Dir;
		if mode == 1 or mode == 3
			dir -= 180;
		len = Time * spd;
	}
	return arrow;
}


enum ARROW_TYPE
{
	NORMAL = 0,
	FLIP = 1,
	DIAGONAL = 2,
	DIAGONAL_FLIP = 3,
}