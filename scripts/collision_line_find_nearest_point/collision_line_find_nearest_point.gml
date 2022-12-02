/// @function		collision_line_find_nearest_point()
/// @description	returns a coordinate array
/// @argument		x start
/// @argument		y start
/// @argument		x end
/// @argument		y end
/// @argument		pixel_accuracy	1 or greater
/// @argument		object_id		The id of objects to collide with
/// @argument		precise			Precise collision checking true or false
function collision_line_find_nearest_point(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var x1	= argument0;
	var y1	= argument1;
	var x2	= argument2;
	var y2	= argument3;

	var direct = point_direction(x1, y1, x2, y2);
	var length = point_distance(x1, y1, x2, y2);

	var accuracy	= clamp(argument4, 1, length);
	var obj			= argument5;
	var prec		= argument6;

	var collision = collision_line(x1, y1, x2, y2, obj, prec, true);

	if(collision != noone) //check if there is actually going to be a collision
	{
		while(length > accuracy)
		{
			length *= 0.5; //halve the segment length
		
			//search first half of segment
			x2 = x1 + lengthdir_x(length, direct);
			y2 = y1 + lengthdir_y(length, direct);
			collision = collision_line(x1, y1, x2, y2, obj, prec, true);
		
			if(collision == noone)
			{
				//search second half of segment
				x1 = x2;
				y1 = y2;
				x2 += lengthdir_x(length, direct);
				y2 += lengthdir_y(length, direct);
			}
		}
	}

	//return collision point as an array
	var point;

	point[0] = x2;
	point[1] = y2;

	return point;


}
