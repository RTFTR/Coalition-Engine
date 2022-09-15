// Feather disable all

function TweenDefine()
{
	/// @function TweenDefine(tween,ease,mode,delta,delay,dur,prop,start,dest,...)
	/// @description Defines a tween previously created with TweenCreate()
	/// @param tween	tween id of previously created tween
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param start	starting value for eased property
	/// @param dest		destination value for eased property
	/// @param ...		(optional) additional properties ("direction", 0, 360)
	/*
		[INFO]
			Defines a previously created tween.
		
		[EXAMPLE]
			tween = TweenCreate(id);
			TweenDefine(tween, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
			TweenPlay(tween);
	*/

	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
		var _tID = _t[TWEEN.ID];
		var _target = _t[TWEEN.TARGET];
		var _propCount = (argument_count-6) div 3;
		var _data;

		// ** Single Property ** //

		if (_propCount == 1)
		{   
		    var _propRaw = argument[6];
    
		    if (is_array(_propRaw)) // Advanced Properties
		    {
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {
					// _data = DATA | START | DESTINATION
					_data = [_propRaw[1], argument[7], argument[8]];
		            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
		        }
		        else
		        {
		            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
		        }
		    }
		    else // Standard Properties
		    { 
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
				{
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // normalized property
			        {
			            // _data = START | DESTINATION
						_data = [argument[7], argument[8]];
			            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
			        }
			        else // optimised property
					if (ds_map_exists(global.__PropertySetters__, _propRaw))
			        {
			            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
			        }
				}
				else // Dynamic Property
				{
					return TGMS_TweenDefine(_tID, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
				}
		    }
		}

		// ** Multi Property ** //

		var _argIndex = 5, _extIndex = 0, _extData;
		_extData[_propCount*5] = 0;
		_extData[0] = _propCount; // Set first ext-data to count of properties

		repeat(_propCount)
		{
		    var _propRaw = argument[++_argIndex];

		    if (is_array(_propRaw)) // Extended Properties
		    {
		        // Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {   // Normalized Property
		            _data = array_create(3);
		            _data[0] = _propRaw[1]; // data
		            _data[1] = argument[++_argIndex]; // real start value
		            _data[2] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {   // Standard Property =================
		            _extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _propRaw[1]; // Property Data
		        }
		
				_extData[++_extIndex] = ""; // Reserved for dynamic property
		    }
		    else // Standard Properties
		    {
				if (ds_map_exists(global.__PropertySetters__, _propRaw))
				{
					// Get raw property setter script
					_propRaw = global.__PropertySetters__[? _propRaw];
		
					// Track raw property
			        _extData[++_extIndex] = _propRaw;
        
			        // Set property data based on standard/normalized types
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
			        {    
						// Normalized Property
			            _data = array_create(2);
			            _data[0] = argument[++_argIndex]; // real start value
			            _data[1] = argument[++_argIndex]; // real destination value
			            _extData[++_extIndex] = 0; // normalized start
			            _extData[++_extIndex] = 1; // normalized destination
			            _extData[++_extIndex] = _data; // data
			        }
			        else
			        {
						// Standard Property
			            _extData[++_extIndex] = argument[++_argIndex]; // start
			            _extData[++_extIndex] = argument[++_argIndex]; // destination
			            _extData[++_extIndex] = _target; // target
			        }
			
					_extData[++_extIndex] = "" // Reserved for dynamic property
				}
				else // Dynamic Property
				{
					// Determine instance/global property setter
					if (variable_instance_exists(_target, _propRaw))
					{
						_extData[++_extIndex] = TGMS_Variable_Instance_Set;
					}
					else
					{
						_extData[++_extIndex] = TGMS_Variable_Global_Set;
					}

			        _extData[++_extIndex] = argument[++_argIndex]; // start
			        _extData[++_extIndex] = argument[++_argIndex]; // destination
					_extData[++_extIndex] = _target; // target
					_extData[++_extIndex] = _propRaw; // variable string
				}
		    }
    
		    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
		    _extData[++_extIndex] = _propRaw;
		}

		return TGMS_TweenDefine(_tID, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
	}

	return undefined;
}

/// @ignore
function TGMS_TweenDefine() 
{
	//  Required by TweenDefine() script
	//  Don't call this directly!

	/// @function TGMS_TweenDefine(tween, ease, mode, detal, dur, prop, start, dest, [...])
	/// @description Defines a tween previously created with TweenCreate()
	/// @param tween	tween id of previously created tween
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param start	starting value for eased property
	/// @param dest		destination value for eased property
	/// @param [...]	(optional) additional properties ("direction", 0, 360)

	var _tID = argument[0];
	var _t = TGMS_FetchTween(_tID);
	if (is_undefined(_t)) { return 0; }

	_t[@ TWEEN.TIME] = 0;
	_t[@ TWEEN.EASE] = argument[2];
	_t[@ TWEEN.MODE] = argument[3];
	_t[@ TWEEN.DELTA] = argument[4];
	_t[@ TWEEN.DELAY_START] = argument[5];
	_t[@ TWEEN.DURATION] = argument[6];
	_t[@ TWEEN.START] = argument[7];
	_t[@ TWEEN.CHANGE] = argument[8]-_t[@ TWEEN.START];
      
	var _property;
	  
	if (argument_count == 9) // Regular property
	{
		_property = argument[1];
		_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
		if (is_string(_property)) // Dynamic Property
		{
			_t[@ TWEEN.VARIABLE] = _property;
		
			if (variable_instance_exists(_t[TWEEN.TARGET], _property))
			{
				_t[@ TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
				_property = TGMS_Variable_Instance_Set;
			}
			else
			{
				_t[@ TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
				_property = TGMS_Variable_Global_Set;
			}
		}
		else // Optimised property
		{
			_t[@ TWEEN.PROPERTY] = _property; // Set tween's property setter script
		}
    
		_t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // Set tween's data as target id
	}
	else // Extended property
	{
		_property[0] = argument[1]; // Set extended property setter script
		_property[1] = argument[9]; // override target data with data
		_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
		_t[@ TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
		var _script = _property[0];     // Cache script to use as property setter
		_property = _script;            // Update cached property setter
		_t[@ TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
	}
}





