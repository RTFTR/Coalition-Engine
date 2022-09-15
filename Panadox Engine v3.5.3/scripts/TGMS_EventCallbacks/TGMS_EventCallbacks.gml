// Feather disable all/// @ignore
function TGMS_EventCallbacks() {}

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

function TweenCallbackNull() 
{
	/// @function TweenCallbackNull()
	/// @description Returns a null callback
	/// @return {undefined}
	
	
	return undefined;
} _=TweenCallbackNull;

	
function TweenAddCallback()
{
	/// @function TweenAddCallback(tween,event,target,script,[arg0...])
	/// @description Adds script to be called on tween event
	/// @param tween		tween id
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param target		instance id or struct used as calling environment (with methods, using *undefined* will use the method's existing "self" environment)
	/// @param script		function or method to call on tween event
	/// @param [arg0,...]	(optional) arguments to pass to script
	/*      
	    INFO:
	        Sets a script to be called on specified tween event.
	        Multiple callbacks can be added to the same event.
        
	        "event" can take any of the following TWEEN_EV_* macros:
	        TWEEN_EV_PLAY
	        TWEEN_EV_FINISH
	        TWEEN_EV_CONTINUE
	        TWEEN_EV_STOP
	        TWEEN_EV_PAUSE
	        TWEEN_EV_RESUME
	        TWEEN_EV_REVERSE 
		
			TWEEN_EV_FINISH_DELAY
			TWEEN_EV_STOP_DELAY
			TWEEN_EV_PAUSE_DELAY
			TWEEN_EV_RESUME_DELAY   
	*/

	var _tID = argument[0];
	var _t = TGMS_FetchTween(_tID);
	if (is_undefined(_t)) { return undefined; }

	var _events = _t[TWEEN.EVENTS];
	var _cb;

	// Create and assign events map if it doesn't exist
	if (_events == -1)
	{
	    _events = ds_map_create();
	    _t[@ TWEEN.EVENTS] = _events;
	}

	var _index = argument_count;
	repeat(_index-4)
	{
	    --_index;
	    _cb[_index] = argument[_index];
	}

	// Set default state as active
	_cb[TWEEN_CALLBACK.ENABLED] = true;
	// Assign tween id to callback
	_cb[TWEEN_CALLBACK.TWEEN] = _tID;
	// Assign script to callback
	_cb[TWEEN_CALLBACK.SCRIPT] = method(undefined, argument[3]);
	
	// Assign target to callback
	if (is_undefined(argument[2])) // IF CALLBACK TARGET IS UNDEFINED
	{
		var _self = method_get_self(argument[3]);
		
		if (is_undefined(_self)) // USE CURRENT CALLING ENVIRONMENT AS SELF IF METHOD'S SELF IS UNDEFINED
		{
			_cb[TWEEN_CALLBACK.TARGET] = is_struct(self) ? weak_ref_create(self) : self;
		}
		else // USE METHOD'S SELF AS TARGET
		{
			_cb[TWEEN_CALLBACK.TARGET] = is_struct(_self) ? weak_ref_create(_self) : _self;
		}
	}
	else // CALLBACK TARGET IS DEFINED -- CHECK BETWEEN STRUCT AND INSTANCE
	{
		if (is_struct(argument[2]))
		{
			_cb[TWEEN_CALLBACK.TARGET] = weak_ref_create(argument[2]);
		}
		else
		if (is_real(argument[2]))
		{
			_cb[TWEEN_CALLBACK.TARGET] = argument[2]; // Not using .id to maintain existing convention
		}
		else // 'self' | 'other'
		{
			_cb[TWEEN_CALLBACK.TARGET] = argument[2].id;
		}
	}
	
	// IF event type exists...
	if (ds_map_exists(_events, argument[1]))
	{
	    // Cache event
	    var _event = _events[? argument[1]];
	    // Add event to events map
	    ds_list_add(_event, _cb);
    
	    // Do some event callback cleanup if size starts to get larger than expected
	    if (ds_list_size(_event) mod 10 == 0)
	    {   
	        ds_priority_add(SharedTweener().eventCleaner, _event, _event);
	    }
	}
	else
	{
	    // Create event list
	    var _event = ds_list_create();
	    // Add STATE and CALLBACK to event
	    ds_list_add(_event, true, _cb);
	    // Add event to events map
	    _events[? argument[1]] = _event;
	}

	// Return callback array
	return _cb;
}_=TweenAddCallback;


function TweenAddCallbackUser(_tween, _event, _target, _user_event) 
{
	/// @function TweenAddCallbackUser(tween,event,target,user_event)
	/// @description Sets a user event to be called on tween event
	/// @param tween		tween id
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param target		instance to call user event
	/// @param user_event	user event to be called (0-15)
	/*        
	    INFO:
	        Sets a user event (0-15) to be called on specified tween event.
	        Multiple callbacks can be added to the same event.
        
	        "event" can take any of the following macros:
	        TWEEN_EV_PLAY
	        TWEEN_EV_FINISH
	        TWEEN_EV_CONTINUE
	        TWEEN_EV_STOP
	        TWEEN_EV_PAUSE
	        TWEEN_EV_RESUME
	        TWEEN_EV_REVERSE    

			TWEEN_EV_FINISH_DELAY
			TWEEN_EV_STOP_DELAY
			TWEEN_EV_PAUSE_DELAY
			TWEEN_EV_RESUME_DELAY  
	*/

	TweenAddCallback(_tween, _event, _target, TGMS_EventUser, _user_event);
}_=TweenAddCallbackUser;


function TweenCallbackEnable(_cb, _enable) 
{
	/// @function TweenCallbackEnable(callback,enable)
	/// @description Enables/disables specified callbacks
	/// @param callback		callback id
	/// @param enable		perform callback?

	if (is_array(_cb))
	{
	    _cb[@ TWEEN_CALLBACK.ENABLED] = _enable;
	}
}_=TweenCallbackEnable;


function TweenCallbackInvalidate(_cb)
{
	/// @function TweenCallbackInvalidate(callback)
	/// @description Removes callback from its associated tween event
	/// @param callback		callback id
	/*      
	    Example:
	        // Create tween and add callback to finish event
	        tween = TweenCreate(id);
	        cb = TweenEventAddCallback(tween, TWEEN_EV_FINISH, id, ShowMessage, "Finished!");
        
	        // Invalidate callback -- effectively removes it from tween event
	        TweenInvalidate(cb);
	*/

	if (is_array(_cb))
	{
	    // Set target as noone -- used for system cleaning
	    _cb[@ TWEEN_CALLBACK.TARGET] = noone;
	    _cb[@ TWEEN_CALLBACK.TWEEN] = TweenNull();
	}
}_=TweenCallbackInvalidate;


function TweenCallbackIsEnabled(_cb) 
{
	/// @function TweenCallbackIsEnabled(callback)
	/// @description Checks if callback is enabled
	/// @param callback		callback id

	if (is_array(_cb))
	{
	    return _cb[TWEEN_CALLBACK.ENABLED] && _cb[@ TWEEN_CALLBACK.TARGET] != noone;
	}
	
	return false;
}_=TweenCallbackIsEnabled;


function TweenCallbackIsValid(_cb)
{
	/// @function TweenCallbackIsValid(callback)
	/// @description Checks if callback id is valid
	/// @param callback		callback id
	/*      
	    Example:
	        if (TweenCallbackValid(callback))
	        {
	            TweenCallbackInvalidate(callback);
	        }
	*/

	if (is_array(_cb))
	{
	    return TweenExists(_cb[TWEEN_CALLBACK.TWEEN]);
	}

	return false;
}_=TweenCallbackIsValid;


function TweenEventClear(_t, _event_type)
{
	/// @function TweenEventClear(tween[s],event)
	/// @description Invalidates all callbacks associated with tween event
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    if (_events != -1)
	    {    
	        if (ds_map_exists(_events, _event_type))
	        {
	            var _event = _events[? _event_type]; 
	            var _index = 0;
            
	            repeat(ds_list_size(_event)-1)
	            {
	                // Get callback
	                var _cb = _event[| ++_index];
	                // Invalidate target
	                _cb[@ TWEEN_CALLBACK.TARGET] = noone;
	            }
	        }
	    }
	}
	else if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventClear, _event_type);
	}
}


function TweenEventEnable(_t, _event_type, _enable)
{
	/// @function TweenEventEnable(tween[s],event,enable)
	/// @description Enables/disables specified tween event
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param enable		enable event?

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    // Create and assign events map if it doesn't exist
	    if (_events == -1)
	    {
	        _events = ds_map_create();
	        _t[@ TWEEN.EVENTS] = _events;
	    }
    
	    if (ds_map_exists(_events, _event_type) == false)
	    {
	        // Create event list
	        var _event = ds_list_create();
	        // Add event to events map
	        _events[? _event_type] = _event;
	    }
    
	    // Set tween event state
	    var _event = _events[? _event_type];
	    _event[| 0] = _enable;
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventEnable, _event_type, _enable);
	}
}


function TweenEventIsEnabled(_t, _event)
{
	/// @function TweenEventIsEnabled(tween,event)
	/// @description Checks if tween event is enabled
	/// @param tween	tween id
	/// @param event	tween event macro (TWEEN_EV_*)

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return 0; }

	// GET events map
	var _events = _t[TWEEN.EVENTS];

	// Return true if events don't exist
	if (_events == -1) { return true; }

	// Return true if event type doesn't exist
	if (ds_map_exists(_events, _event) == false) { return true; }

	// Return event's [enabled] state boolean
	return ds_list_find_value(_events[? _event], 0);
}_=TweenEventIsEnabled;







