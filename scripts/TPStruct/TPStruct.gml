// Feather disable all


function TPStruct(_struct, _name)
{
	/// @function TPStruct(struct,name)
	/// @param struct
	/// @param name
	/// @return {array}
	
	static _ = TGMS_BuildProperty(TPStruct,
		function(_value, _data) 
		{ 
			_data[0][$ _data[1]] = _value; // data = [struct, name]
		},
		function(_data)
		{	
			return _data[0][$ _data[1]]; // data = [struct, name] 
		}
	);
	
	return [TPStruct, [_struct, _name]];
}




