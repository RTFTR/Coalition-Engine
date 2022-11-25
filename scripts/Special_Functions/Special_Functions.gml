///@desc Returns a Positive Quotient of the 2 values
///@param {real} a The number to be divided
///@param {real} b The number to divide
///@return {real}
function Posmod(a,b)
{
	var value = a % b;
	if (value < 0 and b > 0) or (value > 0 and b < 0) 
		value += b;
	return value;
}

///@desc idk but it's for board so don't touch i guess
function point_xy(p_x, p_y)
{
	var angle = image_angle
	
	point_x = ((p_x - x) * dcos(-angle)) - ((p_y - y) * dsin(-angle)) + x
	point_y = ((p_y - y) * dcos(-angle)) + ((p_x - x) * dsin(-angle)) + y
}

///@desc Returns the summation of an array from a to b
///@param {array} array		The name of the array
///@param {real}  begin		The slot to begin
///@param {real}  end		The slot to end
function Sigma(arr, n, k)
{
	var value = 0;
	for(var i = n; i <= k; ++i)
		value += arr[i];
	return value;
}

///@desc Returns an array that acts as a vector 2
function vec2(vec1, vec2) {return [vec1, vec2];}

///@desc Returns an array that acts as a vector 3
function vec3(vec1, vec2, vec3){return [vec1, vec2, vec3];}

///@desc Returns an array that acts as a vector 4
function vec4(vec1, vec2, vec3, vec4) {return [vec1, vec2, vec3, vec4];}

///@desc Checks if the value is equal to the other given values
function is_val()
{
	for (var i = 1; i < argument_count; ++i)
	{
		if argument[0] == argument[i]
		{
			return 1;
			exit;
		}
	}
	return 0;
}

//Checks whether the instance is outside the camera DETERMINED BY IT'S HITBOX
function check_outside(){
	var cam = view_camera[0];
	var view_x = camera_get_view_x(cam);
	var view_y = camera_get_view_y(cam);
	var view_w = camera_get_view_width(cam);
	var view_h = camera_get_view_height(cam);
	
	return !rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, view_x, view_y, view_x + view_w, view_y + view_h) 
	and (
		(x < -sprite_width) or 
		(x > (room_width + sprite_width)) or
		(y > (room_height + sprite_height)) or
		(y < (-sprite_height))
		)
}

