/**
	Converts a string to an array
	@param {string} string	The string to convert the array to
 */
function string_to_array(str)
{
	var i = 1, arr = [];
	repeat string_length(str)
		array_push(arr, string_copy(str, i++, 1));
	return arr;
}