// Feather disable all

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

function TweenFire()
{
	/// @function TweenFire(target,ease,mode,delta,delay,dur,prop,start,dest,[...])
	/// @description Tween a property between start/destination values (auto-destroyed)
	/// @param target	instance to associate with tween (id or object index)
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param start	starting value for eased property
	/// @param dest		destination value for eased property
	/// @param [...]	(optional) additional properties ("direction", 0, 360)
	/*
	    Info:
	        Eases a variable between a specified start and destination value over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,start,dest) order.
    
	    Examples:
	        // Ease "x" value from (x) to (mouse_x), over 1 second
	        TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
	        // Ease "x" and "y" values from (x, y) to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFire(obj_Player, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60, x__, x, mouse_x, y__, y, mouse_y);
        
	    Note: 
	        TweenFire() is required. It's support script, TGMS_TweenFire(), is also required.  
	        However, additional *To/*From/*Create/*Play scripts can be safely deleted if desired.
	*/

	var _target = argument[0].id;
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
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
	        }
	    }
	    else // Standard Properties
	    { 
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
			{
				// normalized property
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) 
		        {
					// _data = START | DESTINATION
					_data = [argument[7], argument[8]];
		            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
		        }
		        else // optimised property
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) 
		        {	
		            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
		        }
			}
			else // Dynamic Property
			{
				return TGMS_TweenFire(_target, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
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
				// Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
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

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
}_=TweenFire;


function TweenFireTo() 
{
	/// @function TweenFireTo(target,ease,mode,delta,delay,dur,prop,to,[...])
	/// @description Tween a property to a destination value (auto-destroyed)
	/// @param target	instance to associate with tween (id or object index)
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param to		value to ease property to
	/// @param [...]	(optional) additional properties ("image_angle", 360)
	/*
	    Info:
	        Eases a variable to a destination value over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,dest) order.
    
	    Examples:
	        // Ease "x" value from (x) to (mouse_x), over 1 second
	        TweenFireTo(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
	        // Ease "x" and "y" values to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFireTo(id, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60,
	            "x", mouse_x,
	            "y", mouse_y);
	*/

	var _target = argument[0].id;
	var _propCount = (argument_count-6) div 2;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{
	    var _propRaw = argument[6];
    
	    if (is_array(_propRaw)) // Advanced Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        { // Normalized
				_data = array_create(3);
	            _data[0] = _propRaw[1]; // data    
	            _data[1] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // start
	            _data[2] = argument[7]; // destination
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
	        { // Not normalized
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target), argument[7], _propRaw[1]);
	        }   
	    }
	    else // Standard Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // Normalized Property
	        {
				_data = array_create(2);
	            _data[0] = global.__PropertyGetters__[? _propRaw](_target); // start
	            _data[1] = argument[7]; // destination
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // Optimised Property
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], global.__PropertyGetters__[? _propRaw](_target), argument[7]);
	        }
			else // Dynamic Property
			{
				var _variable = argument[6];
			
				if (variable_instance_exists(_target, _variable))
				{
					var _dest = variable_instance_get(_target, _variable);
				}
				else
				{
					var _dest = variable_global_get(_variable);
				}
			
				return TGMS_TweenFire(_target, _variable, argument[1], argument[2], argument[3], argument[4], argument[5], _dest, argument[7]);
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
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]]; // Raw property Script?
        
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
	            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw[0]]( _propRaw[1], _target); // start
	            _extData[++_extIndex] = argument[++_argIndex]; // destination
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
		            _data[0] = global.__PropertyGetters__[? _propRaw](_target); // real start value
		            _data[1] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
		            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw](_target); // start
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
					_extData[++_extIndex] = variable_instance_get(_target, _propRaw); // start
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
					_extData[++_extIndex] = variable_global_get(_propRaw); // start
				}

		        _extData[++_extIndex] = argument[++_argIndex]; // destination
				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
}_=TweenFireTo;


function TweenFireFrom()
{
	/// @function TweenFireFrom(target,ease,mode,delta,delay,dur,prop,from,[...])
	/// @description Tween a property from a start value (auto-destroyed)
	/// @param target	instance to associate with tween (id or object index)
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param from		value to ease property from
	/// @param [...]	(optional) additional properties ("image_angle", 360)
	/*
	    Info:
	        Eases a variable from a starting position over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,start) order.
    
	    Examples:
	        // Ease "x" value from (mouse_x), over 1 second
	        TweenFireFrom(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", mouse_x);
        
	        // Ease "x" and "y" values from (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFireFrom(id, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60,
	            "x", mouse_x,
	            "y", mouse_y);
	*/

	var _target = argument[0].id;
	var _propCount = (argument_count-6) div 2;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{
	    var _propRaw = argument[6];
    
	    if (is_array(_propRaw)) // Advanced Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        { // Normalized
				_data = array_create(3);
	            _data[0] = _propRaw[1]; // data    
				_data[1] = argument[7]; // start
	            _data[2] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // destination
            
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
	        { // Not normalized
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target), _propRaw[1]);
	        }   
	    }
	    else // Standard Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // Normalized Property
	        {
				_data = array_create(2);
				_data[0] = argument[7]; // start
	            _data[1] = global.__PropertyGetters__[? _propRaw](_target); // destination
            
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // Optimised Property
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], global.__PropertyGetters__[? _propRaw](_target));
	        }
			else // Dynamic Property
			{
				var _variable = argument[6];
			
				if (variable_instance_exists(_target, _variable))
				{
					var _dest = variable_instance_get(_target, _variable);
				}
				else
				{
					var _dest = variable_global_get(_variable);
				}
			
				return TGMS_TweenFire(_target, _variable, argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], _dest);
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
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]]; // Raw property Script?
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {   // Normalized Property
	            _data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[++_argIndex]; // real start value           // :: THIS SEEMS WRONG TO ME -- NORMALIZED ADVANCED PROPERTY
	            _data[2] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
	            _extData[++_extIndex] = _data; // data
	        }
	        else
	        {   // Standard Property =================
				_extData[++_extIndex] = argument[++_argIndex]; // start
				_extData[++_extIndex] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // dest
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
					_data[0] = argument[++_argIndex]; // real start value
		            _data[1] = global.__PropertyGetters__[? _propRaw](_target); // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
					_extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw](_target); // destination
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
					_extData[++_extIndex] = argument[++_argIndex]; // start
					_extData[++_extIndex] = variable_instance_get(_target, _propRaw); // dest
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
					_extData[++_extIndex] = argument[++_argIndex]; // start
					_extData[++_extIndex] = variable_global_get(_propRaw); // dest
				}

				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
}_=TweenFireFrom;

/// @ignore
function TGMS_TweenFire()
{
	/// @function TGMS_TweenFire(target,prop,ease,mode,delta,delay,dur,start,dest,[...])
	/// @description Base script for TweenFire* scripts -- DO NOT USE DIRECTY!!
	/// @param target	instance to associate with tween (id or object index)
	/// @param prop		property setter string or TP*() script
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param start	starting value for eased property
	/// @param dest		destination value for eased property
	/// @param [...]	(optional) For extended properties
	//  REQUIRED - Don't delete!
	//  Don't call this directly!
	
	var _sharedTweener = SharedTweener();
	var _tID = ++global.TGMS_INDEX_TWEEN;							 // Get new tween id
	var _t  = array_create(TWEEN.DATA_SIZE);						 // Create new tween array
	array_copy(_t, 0, global.TGMS_TweenDefault, 0, TWEEN.DATA_SIZE); // Copy default tween
	
	_t[TWEEN.ID] = _tID;							// Assign new tween id
	_t[TWEEN.TARGET] = argument[0];					// Set target to instance
	_t[TWEEN.EASE] = argument[2];					// Set tween's ease algorithm
	_t[TWEEN.MODE] = argument[3];					// Set tween play mode
	_t[TWEEN.DELTA] = argument[4];					// Set delta
	_t[TWEEN.DURATION] = argument[6];				// Set tween's duration
	_t[TWEEN.START] = argument[7];					// Set start value
	_t[TWEEN.CHANGE] = argument[8]-_t[TWEEN.START]; // Calculate change value (dest-start)

	var _property;

	if (argument_count == 9) // Regular property
	{
	    _property = argument[1];
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
		if (is_string(_property)) // Dynamic Property
		{
			_t[TWEEN.VARIABLE] = _property;
		
			if (variable_instance_exists(_t[TWEEN.TARGET], _property))
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
				_property = TGMS_Variable_Instance_Set;
			}
			else
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
				_property = TGMS_Variable_Global_Set;
			}
		}
		else // Optimised property
		{
			_t[TWEEN.PROPERTY] = _property; // Set tween's property setter script
		}
    
	    _t[TWEEN.DATA] = argument[0];       // Set tween's data as target id
	}
	else // Extended property
	{
		// Set extended property setter script
		// override target data with data
		_property = [argument[1], argument[9]];
		//_property = array_create(2);
	    //_property[0] = argument[1];	 // Set extended property setter script		
	    //_property[1] = argument[9];	 // override target data with data	
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	    _t[TWEEN.DATA] = _property[1];		// Set tween's data to extended arguments
	    var _script = _property[0];			// Cache script to use as property setter
	    _property = _script;				// Update cached property setter
	    _t[TWEEN.PROPERTY] = _script;		// Set tween's property setter script   
	}

	if (argument[5] <= 0) // If no delay set  
	{ 
	    _t[TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween state as playing
		_property(_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	}
	else // Delay is set
	{
	    _t[TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set state as delayed
	    _t[TWEEN.DELAY] = argument[5]; // Assign delay list reference to tween
	    _t[TWEEN.DELAY_START] = argument[5]; // Set starting delay time
	    ds_list_add(_sharedTweener.delayedTweens, _t); // Add tween to global delayed list   
	}

	ds_list_add(_sharedTweener.tweens, _t); // Add tween to global tweens list
	global.TGMS_MAP_TWEEN[? _tID] = _t; // Associate tween with global id
	return _tID; // Return tween id
}







