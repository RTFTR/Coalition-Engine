// Feather disable all

function TPMap(_map, _key)
{
	/// @function TPMap(map,key)
	/// @param map
	/// @param key
	/// @return {array}

	static _ = TGMS_BuildProperty(TPMap,
		function(_value, _data)
		{
			ds_map_replace(_data[0], _data[1], _value);
		},
		function(_data)
		{
			return ds_map_find_value(_data[0], _data[1]);
		}
	);
		
	return [ TPMap, [_map, _key] ];
}



