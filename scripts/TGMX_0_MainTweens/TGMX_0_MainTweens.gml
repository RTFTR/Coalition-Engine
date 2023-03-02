// Feather ignore all

// TweenFire			-- required
// TweenCreate			-- required
// TweenPlay			-- required
// TweenPlayDelay		-- safe to delete
// TweenMore			-- safe to delete
// TweenScript			-- safe to delete
// TweenMoreScript		-- safe to delete
// TweenDefine			-- safe to delete

var _; // USED TO HIDE SYNTAX WARNINGS FOR NON-FEATHER ENVIRONMENT

// @function TweenFire( target, ease, mode, delta, delay, duration, prop, start, dest, ... )
/// @description Tween a property between start/destination values (auto-destroyed)
/// @param {Any}	target		instance or struct to associate with tween
/// @param {Any}	ease		easing script index or animation curve (e.g. EaseInQuad, EaseLinear)
/// @param {Any}	mode		tween mode (0="once", 1="bounce", 2="patrol", 3="loop", 4="repeat")
/// @param {Any}	delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any}	delay		amount of time to delay tween before playing
/// @param {Any}	dur			duration of time to play tween
/// @param {Any}	prop		property setter string (e.g. "x") or TP*() script
/// @param {Any}	start		starting value for eased property
/// @param {Any}	dest		destination value for eased property
/// @param {Any}	[...]		[OPTIONAL] additional properties ("direction", 0, 360) or advanced actions ("-group", 2)
function TweenFire()
{
	/*
		Info:
		    Eases one or more variables/properties between a specified start and destination value over a set duration of time.
		    Additional properties can be added as optional arguments. Additional properties must use (property,start,dest) order.
    
		Examples:                                  
		    // Ease "x" value from (x) to (mouse_x), over 1 second
		    TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
		    // Ease "x" and "y" values from (x, y) to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
		    // Tween will play back and forth, repeatedly.
		    TweenFire(obj_Player, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60, "x", x, mouse_x, "y", y, mouse_y);
	*/
	
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	// "OFF-RAIL" TWEEN CALL
	if (is_string(argument[0]) || is_array(argument[0]))
	{		
		var _args = array_create(argument_count);
		_args[0] = argument[0]; // We already know the first argument...
		
		var i = 0;
		repeat(argument_count-1)
		{
			i += 1;
			_args[i] = argument[i];
		}
		
		return TGMX_Tween(TweenFire, _args, 0);
	}

	// DEFAULT TWEEN CALL
	var _args = [undefined, argument[0], argument[1], argument[2], argument[3], argument[4], argument[5]];
	array_resize(_args, argument_count+1);
	
	var i = 6;
	repeat(argument_count-6)
	{
		i += 1;
		_args[i] = argument[i-1];
	}

	return TGMX_Tween(TweenFire, _args, 0);
}


/// @function TweenCreate( target, [ease, mode, delta, delay, dur, prop, start, dest, ...] )
/// @description Creates a tween to be started with TweenPlay*() (not auto-destroyed)
/// @param {Any}	target		instance or struct to associate with tween
/// @param {Any}	[ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any}	mode		tween mode (0="once", 1="bounce", 2="patrol", 3="loop", 4="repeat")
/// @param {Any}	delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any}	delay		amount of time to delay tween before playing
/// @param {Any}	dur			duration of time to play tween
/// @param {Any}	prop		property setter string or TP*() script
/// @param {Any}	start		starting value for eased property
/// @param {Any}	dest]		destination value for eased property
//  @param {Any}	...			[OPTIONAL] additional properties ("direction", 0, 360)
function TweenCreate()
{
	/*
		Creates and returns a new tween. The tween does not start right away, but must
		be played with the TweenPlay*() scripts.
		Unlike TwenFire*(), tweens created with TweenCreate() will exist in memory until either
		their target instance is destroyed or TweenDestroy(tween) is manually called.
		You can set them to auto-destroy with TweenDestroyWhenDone(tween, true):
	
		Defining a tween at creation is optional. Both of the following are valid:
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenDestroyWhenDone(tween2, true); // Have tween auto-destroy when finished
	*/
	
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	// RETURN UNDEFINED TWEEN WITH ASSUMED TARGET IF NO ARGUMENTS GIVEN
	if (argument_count == 0)
	{
		return TGMX_Tween(TweenCreate, [undefined, self], 0); 
	}
	
	// HANDLE "OFF-RAIL" TWEEN CALL
	if (is_string(argument[0]) || is_array(argument[0]))
	{
		var _args = array_create(argument_count);
		var i = -1;
		repeat(argument_count)
		{
			i += 1;
			_args[i] = argument[i];
		}
		
		return TGMX_Tween(TweenCreate, _args, 0);
	}
	
	// RETURN UNDEFINED TWEEN WITH EXPLICIT TARGET
	if (argument_count == 1)
	{
		return TGMX_Tween(TweenCreate, [undefined, argument[0]], 0);
	}

	// DEFAULT TWEEN CALL
	var _args = [undefined, argument[0], argument[1], argument[2], argument[3], argument[4], argument[5]];
	array_resize(_args, argument_count+1);
	
	var i = 6;
	repeat(argument_count-6)
	{
		i += 1;
		_args[i] = argument[i-1];
	}

	return TGMX_Tween(TweenCreate, _args, 0);
}



// @function TweenPlay( tween, [ease, mode, delta, delay, dur, prop, start, dest, ...] )
/// @description	Plays a tween previously created with TweenCreate()
/// @param {Any}	tween{s}	tween id of previously created tween
/// @param {Any}	[ease		tween mode (0="once", 1="bounce", 2="patrol", 3="loop", 4="repeat")
/// @param {Any}	mode		whether or not to use delta/seconds timing(true) or step timing(false)
/// @param {Any}	delta		whether or not to use delta/seconds timing(true) or step timing(false)
/// @param {Any}	delay		amount of time to delay tween before playing
/// @param {Any}	dur			duration of time to play tween
/// @param {Any}	prop		property setter string or TP*() script
/// @param {Any}	start		starting value for eased property
/// @param {Any}	dest]		destination value for eased property
//  @param {Any} ...			(optional) additional properties ("direction", 0, 360)
function TweenPlay() 
{
	/*
		Defining a tween at creation is optional. Both of the following are valid:
			tween1 = TweenCreate(self);
			tween2 = TweenCreate(self, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenPlay(tween1, EaseInQuad, 0, true, 0, 1.0, "a", 0, 100);
			TweenPlay(tween2);
	*/
	
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	var _tween = TGMX_FetchTween(argument[0]);
	
	// MULTI-TWEEN EXECUTION
	if (is_struct(_tween)) { TGMX_TweensExecute(_tween, TweenPlay); return; }

	// PRE-DEFINED TWEEN CALL
	if (argument_count == 1) { return TGMX_Tween(TweenPlay, [], argument[0]); }

	// OFF-RAIL TWEEN CALL
	if ( (is_string(argument[1]) && global.TGMX.ShorthandTable[string_byte_at(argument[1], 1)]) || (is_array(argument[1]) && array_length(argument[1]) > 2) )
	{
		var _args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			i += 1;
			_args[i] = argument[i+1];
		}
			
		return TGMX_Tween(TweenPlay, _args, argument[0]);
	}
	
	// DEFAULT TWEEN CALL
	var _args = [undefined, argument[1], argument[2], argument[3], argument[4], argument[5]];
	array_resize(_args, argument_count);

	var i = 5;
	repeat(argument_count-6)
	{
		i += 1;
		_args[i] = argument[i];
	}
	
	return TGMX_Tween(TweenPlay, _args, argument[0]);
}


/// @function TweenPlayDelay( tween[s], delay )
/// @description Plays tween[s] defined with TweenCreate*() after a set delay
/// @param {Any} tween{s}		id of previously created/defined tween[s]
/// @param {Any} delay			amount of time to delay start
function TweenPlayDelay(_t, _delay)
{
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	_t = TGMX_FetchTween(_t);

	if (is_array(_t))
	{
	    _t[@ TGMX_T_DELAY] = _delay;
		TGMX_Tween(TweenPlay, [], _t[TGMX_T_ID]); // NOTE: THIS COULD CAUSE AN ERROR BECAUSE OF THE EMPTY ARRAY???
	}
    else
	if (is_struct(_t))
	{
	    TGMX_TweensExecute(_t, TweenPlayDelay, _delay);
	}
}


/// @function TweenMore( tween, target, ease, mode, delta, delay, dur, prop, start, dest, ... )
/// @description Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes
/// @param {Any} tween		tween id
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
//  @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
function TweenMore()
{	
	/*
	    Info:
			Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes.
			Multiple new tweens can be added to the same tween, allowing for branching chains.
			Tween is automatically destroyed when finished, stopped, or if its associated target instance is destroyed.
			Returns unique tween id.   
    
	    Examples:
	        // Chain various tweens to fire one after another
			tween1 = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			tween2 = TweenMore(tween1, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			tween3 = TweenMore(tween2, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			tween4 = TweenMore(tween3, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
		
			t = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			TweenMore(t, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			TweenMore(t+1, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			TweenMore(t+2, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
		
			// 0 can be used to refer to the last created tween
			TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			TweenMore(0, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			TweenMore(0, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			TweenMore(0, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
	*/
	
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	var _args;

	if (is_string(argument[1]))
	{
		_args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			i += 1;
			_args[i] = argument[i+1];
		}
	}
	else
	{
		_args = [undefined, argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]];
		array_resize(_args, argument_count);

		var i = 6;
		repeat(argument_count-7)
		{
			i += 1;
			_args[i] = argument[i];
		}
	}
	
	var _tween = TGMX_FetchTween(argument[0]);
	var _newTween = TGMX_Tween(TweenCreate, _args, 0);
	TweenDestroyWhenDone(_newTween, _tween[TGMX_T_DESTROY]);
	TweenAddCallback(_tween, TWEEN_EV_FINISH, SharedTweener(), TweenPlay, _newTween);
	return _newTween;
}_=TweenMore;


/// @function TweenScript( target, delta, dur, script, [arg0, ...] )
/// @description Schedules a script to be executed after a set duration of time
/// @param {Any} target		target instance id
/// @param {Any} delta		use seconds timing? (true=seconds | false = steps)
/// @param {Any} dur		duration of time before script is called
/// @param {Any} script		script to execute when timer expires
/// @param {Any} [arg0,...]	(optional) additonal arguments to pass to script
function TweenScript(_target, _delta, _dur, _script)
{	
	/*
	    Info:
	        Schedules a script to be executed after a set duration of time.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye, World!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/

	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();

	var _args = array_create(argument_count);
	_args[1] = TWEEN_EV_FINISH;
	_args[3] = _script; //cb script
	
	// Handle advanced target setting
	if (is_undefined(_target))
	{
		_args[0] = TweenFire("^", _delta, "$", _dur); 
		_args[2] = _target; // cb target
	}
	else
	if (is_array(_target))
	{
		var _target_array = _target;
		_args[0] = TweenFire("?", _target_array[0], "^", _delta, "$", _dur); 
		_args[2] = _target_array[1]; // cb target
	}
	else // ASSUME INSTANCE OR STRUCT TARGET
	{
		_args[0] = TweenFire("?", _target, "^", _delta, "$", _dur); 
		_args[2] = _target; // cb target
	}
	
	var i = 3;
	repeat(argument_count-4)
	{
		i += 1;
		_args[i] = argument[i];
	}
	
	script_execute_ext(TweenAddCallback, _args);
	return _args[0];
}_=TweenScript;


/// @function TweenMoreScript( tween, target, delta, dur, script, [arg0, ...])
/// @description Allows for the chaining of script scheduling
/// @param {Any} tween		tween id
/// @param {Any} target		target instance
/// @param {Any} delta		use seconds timing? (true=seconds | false = steps)
/// @param {Any} dur		duration of time before script is called
/// @param {Any} script		script to execute when timer expires
/// @param {Any} [arg0,...]	(optional) arguments to pass to script
function TweenMoreScript()
{	
	/*	
	    Info:
	        Allows for the chaining of script scheduling.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/

	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();

	var _newTween;
	var _ogTween = TGMX_FetchTween(argument[0]); // Note: This needs to be first inorder to support [0] relevant tween ids
	var _args = array_create(argument_count-1);
	_args[1] = TWEEN_EV_FINISH;
	_args[3] = argument[4]; // Script
	
	if (is_undefined(argument[1])) // TARGET IS UNDEFINED
	{
		_newTween = TweenCreate("^", argument[2], "$", argument[3]);
		_args[2] = argument[1]; // cb target
	}
	else
	if (is_array(argument[1])) // ARRAY TARGET [tween_target, callback_target]
	{
		var _target_array = argument[1];
		_newTween = TweenCreate("?", _target_array[0], "^", argument[2], "$", argument[3]);
		_args[2] = _target_array[1]; // cb target
	}
	else // ASSUME INSTANCE OR STRUCT TARGET
	{
		_newTween = TweenCreate("?", argument[1], "^", argument[2], "$", argument[3]);
		_args[2] = argument[1]; // cb target
	}
	
	_args[0] = _newTween;
	TweenDestroyWhenDone(_newTween, true);
	TweenAddCallback(_ogTween[TGMX_T_ID], TWEEN_EV_FINISH, SharedTweener(), TweenPlay, _newTween);

	// Add remaining script arguments
	var i = 3;
	repeat(argument_count-5)
	{
		i += 1;
		_args[i] = argument[i+1];
	}
	
	script_execute_ext(TweenAddCallback, _args);
	return _newTween;
}_=TweenMoreScript;


/// @function TweenDefine( tween, ease, mode, delta, delay, dur, prop, start, dest, [...] )
/// @description			Redefines a tween
/// @param {Any} tween		tween id of previously created tween
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0="once", 1="bounce", 2="patrol", 3="loop", 4="repeat")
/// @param {Any} delta		whether or not to use delta/seconds timing(true) or step timing(false)
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
//  @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
function TweenDefine() 
{	
	/*
		tween = TweenCreate(id);
		TweenDefine(tween, "io", "once", true, 0, 1, "x", 0, 100); 
	*/
	
	// MAKE SURE TWEENER HAS BEEN CREATED AT LEAST ONCE
	static _ = SharedTweener();
	
	var _curTween = TGMX_FetchTween(argument[0]);
	
	// Get original values to reassign later
	var _ogID = _curTween[TGMX_T_ID];
	var _ogTarget = _curTween[TGMX_T_TARGET];
	var _ogState = _curTween[TGMX_T_STATE];
	var _ogTime = _curTween[TGMX_T_TIME];
	var _ogGroup = _curTween[TGMX_T_GROUP];
	var _ogDirection = _curTween[TGMX_T_DIRECTION];
	var _ogEvents = _curTween[TGMX_T_EVENTS];
	var _ogDestroyState = _curTween[TGMX_T_DESTROY];
	
	// Set tween values to defautls
	array_copy(_curTween, 0, global.TGMX.TweenDefault, 0, TGMX_T_DATA_SIZE);
	
	// Reassign the original values we want to carry over
	_curTween[@ TGMX_T_ID] = _ogID;
	_curTween[@ TGMX_T_TARGET] = _ogTarget;
	_curTween[@ TGMX_T_STATE] = _ogState;
	_curTween[@ TGMX_T_TIME] = _ogTime;
	_curTween[@ TGMX_T_GROUP] = _ogGroup;
	_curTween[@ TGMX_T_DIRECTION] = _ogDirection;
	_curTween[@ TGMX_T_EVENTS] = _ogEvents;
	_curTween[@ TGMX_T_DESTROY] = _ogDestroyState;
	
	var _args;

	if (argument_count == 1) // WHY IS THIS HERE?? DOES IT SERVE ANY PURPOSE??
	{
		_args = [];
	}
	else // OFF-RAIL CALL
	if ( (is_string(argument[1]) && global.TGMX.ShorthandTable[string_byte_at(argument[1], 1)]) || (is_array(argument[1]) && array_length(argument[1]) > 2) )
	{
		_args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			i += 1;
			_args[i] = argument[i+1];
		}
	}
	else // DEFAULT ON-RAIL CALL
	{	
		_args = [undefined, argument[1], argument[2], argument[3], argument[4], argument[5]];
		
		array_resize(_args, argument_count);

		var i = 5;
		repeat(argument_count-6)
		{
			i += 1;
			_args[i] = argument[i];
		}
	}
	
	return TGMX_Tween(TweenDefine, _args, argument[0]);
}













