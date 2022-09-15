// Feather disable all

function TPList(_list, _index)
{
	/// @function TPList(list,index)
	/// @param list
	/// @param index
	/// @return {array}

	static _ = TGMS_BuildProperty(TPList,
		function(_value, _data)
		{
			ds_list_replace(_data[0], _data[1], _value);
		},
		function(_data)
		{
			return ds_list_find_value(_data[0], _data[1]);
		}
	);

	return [ TPList, [_list, _index] ];
}




