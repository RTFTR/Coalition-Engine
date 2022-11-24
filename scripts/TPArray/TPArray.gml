// Feather disable all

function TPArray(_array, _x, _y=undefined)
{
	/// @function TPArray(array,x,[y])
	/// @description Allows array index to be tweened as a property
	/// @param {array} array
	/// @param x
	/// @param [y]
	/// @return {array}

	static _ = TGMS_BuildProperty(TPArray, 
		function(_value,_data) 
		{
			_data[0][@ _data[1]] = _value; 
		},
		function(_data) 
		{ 
			return _data[0][_data[1]]; 
		}
	);	
	
	return [ TPArray, (is_undefined(_y) ? [_array, _x] : [_array[_x], _y]) ];
}






