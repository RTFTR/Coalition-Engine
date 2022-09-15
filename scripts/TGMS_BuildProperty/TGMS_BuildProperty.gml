// Feather disable all

/// @function TGMS_BuildProperty("label",setter,getter)
/// @description Prepares a property to be optimised for TweenGMS
function TGMS_BuildProperty(_label, _setter, _getter) 
{
	/// @param "label"		string to associate with property
	/// @param setter		setter function to associate with property
	/// @param getter		getter function to associate with property

	global.__PropertySetters__[? _label] = method(undefined, _setter);
	global.__PropertyGetters__[? _label] = method(undefined, _getter);
}


/// TGMS_BuildPropertyNormalize("label",setter,getter)
/// @description Prepares a normalized property to be usable by TweenGMS
function TGMS_BuildPropertyNormalize(_label, _setter, _getter)
{
	/// @param "label"		string to associate with property
	/// @param setter		setter script to associate with property
	/// @param getter		getter script to assocaite with property

	/*
		Info:
			Normalized property scripts receive an eased value between 0 and 1
			with additional data passed for the start/dest values.
			See image_blend__ script for an example.
	*/

	global.__NormalizedProperties__[? _label] = 1;
	TGMS_BuildProperty(_label, _setter, _getter);
}



