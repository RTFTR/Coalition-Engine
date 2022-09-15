// Feather disable all

/// @ignore
function TGMS_DefaultProperties()
{
	/*
		Set up default properties for optimisation or normalization purposes.
		This is NOT REQUIRED for custom properties/variables to be used, but they will
		perform slower than tweens set up with TGMS_BuildProperty().
	
		It is advised to create your own list of custom properties elsewhere.
		It is safe to delete any properties and their associated scripts.
	
		Note:
			Properties like "image_blend" require to be built in order 
			to function as intended since they are normalized.
	*/
	
	// NOTE:
	//	_v = value
	//  _t = target
	//  _d = data

	//=========================
	// GLOBAL PROPERTIES
	//=========================
	TGMS_BuildProperty("score", function(_v){ score = _v; }, function(){ return score; });
	TGMS_BuildProperty("health", function(_v){ health = _v; }, function(){ return health; });
	TGMS_BuildPropertyNormalize("background_colour", function(_v,_d){ background_colour = merge_colour(_d[0], _d[1], _v); }, function(){ return background_colour; });
	TGMS_BuildPropertyNormalize("background_color", function(_v,_d){ background_color = merge_colour(_d[0], _d[1], _v); }, function(){ return background_color; });
		
	//=====================
	// INSTANCE VARIABLES
	//=====================
	TGMS_BuildProperty("", function(){}, function(){ return 0; });
	TGMS_BuildProperty("x", function(_v,_t){ _t.x = _v; }, function(_t){ return _t.x; });
	TGMS_BuildProperty("y", function(_v,_t){ _t.y = _v; }, function(_t){ return _t.y; });
	TGMS_BuildProperty("z", function(_v,_t){ _t.z = _v; }, function(_t){ return _t.z; });
	TGMS_BuildProperty("round(x)", function(_v,_t){ _t.x = round(_v); }, function(_t){ return _t.x; });
	TGMS_BuildProperty("round(y)", function(_v,_t){ _t.y = round(_v); }, function(_t){ return _t.y; });
	TGMS_BuildProperty("round(z)", function(_v,_t){ _t.z = round(_v); }, function(_t){ return _t.z; });
	TGMS_BuildProperty("direction", function(_v,_t){ _t.direction = _v; }, function(_t){ return _t.direction; });
	TGMS_BuildProperty("speed", function(_v,_t){ _t.speed = _v; }, function(_t){ return _t.speed; });
	TGMS_BuildProperty("hspeed", function(_v,_t){ _t.hspeed = _v; }, function(_t){ return _t.hspeed; });
	TGMS_BuildProperty("vspeed", function( _v,_t){ _t.vspeed= _v; }, function(_t){ return _t.vspeed; });
	TGMS_BuildProperty("image_alpha", function(_v,_t){ _t.image_alpha= _v; }, function(_t){ return _t.image_alpha; });
	TGMS_BuildProperty("image_angle", function(_v,_t){ _t.image_angle= _v; }, function(_t){ return _t.image_angle; });
	TGMS_BuildProperty("image_scale", function(_v,_t){ _t.image_xscale = _v; _t.image_yscale = _v; }, function(){ return _t.image_xscale; });
	TGMS_BuildProperty("image_xscale", function(_v,_t){ _t.image_xscale = _v; }, function(_t){ return _t.image_xscale; });
	TGMS_BuildProperty("image_yscale", function(_v,_t){ _t.image_yscale = _v; }, function(_t){ return _t.image_yscale; });
	TGMS_BuildProperty("image_index", function(_v,_t){ _t.image_index = _v; }, function(_t){ return _t.image_index; });
	TGMS_BuildProperty("image_speed", function(_v,_t){ _t.image_speed = _v; }, function(_t){ return _t.image_speed; });
	TGMS_BuildPropertyNormalize("image_blend", function(_v,_d,_t){ _t.image_blend = merge_colour(_d[0], _d[1], _v); }, function(_t){ return _t.image_blend; });
	TGMS_BuildProperty("path_orientation", function(_v,_t){ _t.path_orientation = _v; }, function(_t){ return _t.path_orientation; });
	TGMS_BuildProperty("path_position", function(_v,_t){ _t.path_position = _v; }, function(_t){ return _t.path_position; });
	TGMS_BuildProperty("path_scale", function(_v,_t){ _t.path_scale = _v; }, function(_t){ return _t.path_scale; });
	TGMS_BuildProperty("path_speed", function(_v,_t){ _t.path_speed = _v; }, function(_t){ return _t.path_speed; });
}


//===============================
// GENERIC AUTO PROPERTY SETTERS
//===============================

/// @ignore
function TGMS_Variable_Global_Set()
{
	/// function TGMS_Variable_Global_Set(value,unused_1,unused_1,variable)
	/// param {real} value
	/// param {string} variable
	
	variable_global_set(argument[3], argument[0]);
}

/// @ignore
function TGMS_Variable_Instance_Set() 
{
	/// function TGMS_Variable_Instance_Set(value, unused, target, variable);
	/// param {real} value
	/// param unsused
	/// param target
	/// param {string} variable
	
	variable_instance_set(argument[2], argument[3], argument[0]);
}













