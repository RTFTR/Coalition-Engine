// Feather disable all


function TPUser(_user_event)
{
	/// @function TPUser(event, [...])
	/// @return {array}
	/*
		[EXAMPLE 1] --> Use user event as tween property
			[SOME EVENT]
			// Fire a tween using TPUser as the property
			TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(0), 0, 100);
		
			[USER EVENT 0]
			// Update value in user event 0
			abc = TWEEN_USER_VALUE;
		
		[EXAMPLE 2] --> Have extended data passed to user event
			[SOME EVENT]
			// Fire a tween using TPUser as the property with extra data
			TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(1, c_white, c_red), 0, 1);
		
			[USER EVENT 1]
			var _value = TWEEN_USER_VALUE;
			var _data = TWEEN_USER_DATA; // This will contain c_white/c_red values
			image_blend = merge_colour(_data[0], _data[1], _value);
		
		[EXAMPLE 3] --> How to set up a user event to support TweenFireTo/From()
			[SOME EVENT]
			// Fire a tween using TPUser as the property
			TweenFireTo(id, EaseLinear, 0, true, 0, 1.0, TPUser(2), 100);
		
			[USER EVENT 0]
			// User Event 2
			if (TWEEN_USER_GET) // GETTER
			{
			    TWEEN_USER_GET = abc;
			}
			else // SETTER
			{
			    abc = TWEEN_USER_VALUE;
			}
	*/
	
	//=====================================
	
	// BUILD PROPERTY SETTER/GETTER
	static _ = TGMS_BuildProperty(TPUser,
		function(_value, _event, _target)
		{
			TWEEN_USER_VALUE = _value;
			TWEEN_USER_TARGET = _target;
			
			with(_target)
			{
				if (is_real(_event)) {
				    event_perform_object(object_index, ev_other, _event);
				}
				else {
				    TWEEN_USER_DATA = _event[1];
				    event_perform_object(object_index, ev_other, _event[0]);
				}
			}
		},
		function(_event, _target)
		{
			TWEEN_USER_TARGET = _target;
			TWEEN_USER_GET = 1;

			with(_target)
			{
				if (is_real(_event)) {
				    event_perform_object(object_index, ev_other, _event);
				}
				else {
				    TWEEN_USER_DATA = _event[1];
				    event_perform_object(object_index, ev_other, _event[0]);
				}

				var _return = TWEEN_USER_GET;
				TWEEN_USER_GET = 0;
				return _return;
			}
		}
	);
	
	
	if (argument_count == 1)
	{
		return [TPUser, ev_user0+_user_event];
	}
	else // Extended Data
	{
	    var _args;
	    var i = -1;
	    repeat(argument_count-1)
	    {
	        ++i;
	        _args[i] = argument[i+1];
	    }
    
		return [TPUser, [ev_user0+_user_event, _args]];
	}
}






