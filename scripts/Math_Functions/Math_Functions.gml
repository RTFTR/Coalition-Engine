function Posmod(a,b)
{
	var value = a % b;
	if (value < 0 and b > 0) or (value > 0 and b < 0) 
		value += b;
	return value;
}

function point_xy(p_x, p_y)
{
	var angle = image_angle
	
	point_x = ((p_x - x) * dcos(-angle)) - ((p_y - y) * dsin(-angle)) + x
	point_y = ((p_y - y) * dcos(-angle)) + ((p_x - x) * dsin(-angle)) + y
}
