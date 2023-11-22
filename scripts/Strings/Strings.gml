/**
	Converts a string to an array
	@param {string} string	The string to convert the array to
 */
function string_to_array(str)
{
	var i = 1, n = string_length(str), arr = [];
	repeat n array_push(arr, string_copy(str, i++, 1));
	return arr;
}
/**
	Converts a array to a string
	@param {Array<string>} array	The array to convert the string to
*/
function array_to_string(arr)
{
	var i = 0, n = array_length(arr), txt = "";
	repeat n txt += arr[i++];
	return txt;
}