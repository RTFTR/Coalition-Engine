// Feather disable all

function TPInst(_inst, _name)
{
	/// @function TPInst(inst, name)
	/// @Description Allows variable of another instance to be passed as a property
	/// @param inst 
	/// @param name
	/// @return {array}
	
	// data = [instance, name, getter, setter]
	
	static _ = TGMS_BuildProperty(TPInst,
		function(_value, _data) // SETTER
		{
			if (instance_exists(_data[0]))
			{
				if (is_undefined(_data[3])) { _data[0][$ _data[1]] = _value; }
				else						{ _data[3](_value, _data[0]); }
			}
		},
		function (_data) // GETTER
		{	
			if (instance_exists(_data[0]))
			{
				if (is_undefined(_data[2])) { return _data[0][$ _data[1]]; }
				else						{ return _data[2](_data[0]); }
			}
			
			return 0;
		}
	);
	
	return [ TPInst, [_inst, _name, global.__PropertyGetters__[? _name], global.__PropertySetters__[? _name]] ];
}




