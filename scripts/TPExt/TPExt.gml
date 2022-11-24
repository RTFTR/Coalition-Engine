// Feather disable all


function TPExt(_property)
{
	/// @function TPExt(property,arg0,...)
	/// @description Prepares an extended property script with custom arguments
	/// @param property		property script
	/// @param arg0			argument to pass to extended property scripts
	/// @param ...			additional arguments to pass to extended property scripts
	/// @return {array}
	
	/*
		[Example]
		
		/// CREATE A SETTER SCRIPT
		function ExtColourBlend(_value, _data, _target)
		{
			_target.image_blend = merge_colour(_data[0], _data[1], _value);
		}
		
		// CREATE A DEFINED TWEEN WITH AN EXTENDED PROPERTY
		tween = TweenCreate(id, EaseInQuad, 0, true, 0.0, 3.0, TPExt(extColourBlend, c_red, c_blue), 0, 1);
	*/

	// CONVERT METHOD TO INDEX
	if (is_method(_property)) { _property = method_get_index(_property); }

	// ADD PROPERTY INDEX TO GLOBAL PROPERTY SETTERS MAP
	if (global.__PropertySetters__[? _property] == undefined) {
		global.__PropertySetters__[? _property] = _property;
	}
	
	if (argument_count == 2)
	{
		return [_property, argument[1]];
	}
	else
	{
	    var _args;
	    var _iArg = -1;
	    repeat(argument_count-1)
	    {
	        ++_iArg;
	        _args[_iArg] = argument[_iArg+1];
	    }
    
		return [_property, _args];
	}
}


