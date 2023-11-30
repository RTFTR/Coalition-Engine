/**
	Returns a Positive Quotient of the 2 values
	@param {real} a The number to be divided
	@param {real} b The number to divide
*/
function posmod(a, b)
{
	var value = a % b;
	while (value < 0 and b > 0) or (value > 0 and b < 0) 
		value += b;
	return value;
}

///Calculating the legnthdir_xy position of the points
function point_xy(p_x, p_y)
{
	var angle = image_angle;
	
	point_x = (p_x - x) * dcos(angle) - (p_y - y) * dsin(-angle) + x;
	point_y = (p_y - y) * dcos(angle) + (p_x - x) * dsin(-angle) + y;
}

///Calculating the legnthdir_xy position of the points
function point_xy_array(p_x, p_y)
{
	var angle = image_angle;
	
	return [(p_x - x) * dcos(angle) - (p_y - y) * dsin(-angle) + x,
	(p_y - y) * dcos(angle) + (p_x - x) * dsin(-angle) + y];
}

///Returns the lengthdir_x/y values in a Vector2 (stupidly useless)
function lengthdir_xy(length, dir) constructor
{
	return new Vector2(lengthdir_x(length, dir), lengthdir_y(length, dir));
}

/**
	Returns the summation of an array from a to b
	@param {array} array	The name of the array
	@param {real}  begin	The slot to begin
	@param {real}  end		The slot to end
*/
function Sigma(arr, n, k)
{
	for(var i = n, value = 0; i <= k; ++i)
		value += arr[i];
	return value;
}

///Checks if the value is equal to the other given values
function is_val()
{
	//for (var i = 1; i < argument_count; ++i)
	//{
	//	if argument[0] == argument[i]
	//	{
	//		return true;
	//	}
	//}
	//return false;
	//If you encounter an error saying array_contains don't exist, use the above method instead
	var arr = [], i = 1;
	repeat argument_count - 1
		array_push(arr, argument[i++]);
	return array_contains(arr, argument[0]);
}

/**
	Multiplies all indexes of the array with given number
	@param {Array} Array	The array to multiply
	@param {real} Multiply	The amount to multiply
*/
function array_multiply(arr, num)
{
	var i = 0, n = array_length(arr);
	repeat n
		arr[i++] *= num;
	return arr;
}

/**
	Check whether the valuye contains the bit
	@param {real} Value	The value to check from
	@param {real} Bit	The bit to check
*/
function is_bit(val, bit)
{
	return (val & bit) != 0;
}