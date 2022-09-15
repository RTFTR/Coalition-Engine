// Feather disable all

function TweenFinish(_t, _call_event=true)
{
	/// @function TweenFinish(tween[s],call_event)
	/// @description Finishes the selected tween[s]
	/// @param tween[s]		tween id
	/// @param call_event	execute FINISH EVENT callbacks?
	/*      
	    INFO:
	        Finishes the specified tween, updating it to its destination.
	        DOES NOT affect tweens using PATROL|LOOP|REPEAT play modes.
	*/

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
	        return;
	    }
    
	    if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        switch(_t[TWEEN.MODE])
	        {
            case TWEEN_MODE_ONCE: _t[@ TWEEN.TIME] = _t[TWEEN.DURATION]; break; // Update tween's time
            case TWEEN_MODE_BOUNCE: _t[@ TWEEN.TIME] = 0; break;				// Update tween's time
            default: return;
	        }
        
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED; // Set tween state as STOPPED
        
	        // Update property with start value
	        _t[TWEEN.PROPERTY](_t[TWEEN.START] + _t[TWEEN.CHANGE]*(_t[TWEEN.TIME] > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
        
	        // Execute finish event IF set to do so
	        if (_call_event)
	        {
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH);
	        }
        
	        // IF tween is set to be destroyed
	        if (_t[TWEEN.DESTROY])
	        {
	            TweenDestroy(_t);
	        }
	    }
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinish, _call_event);
	}
}


function TweenFinishDelay(_t, _call_event=true)
{
	/// @function TweenFinishDelay(tween[s],call_event)
	/// @description Finishes delay for the selected tween[s]
	/// @param tween[s]		tween id
	/// @param call_event	execute FINISH EVENT callbacks?

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
	        _t[@ TWEEN.DELAY] = -1; // Mark delay for removal from delay list
        
	        // Execute FINISH DELAY event
	        if (_call_event)
	        {
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY);
	        }
        
	        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween as active                
        
	        // Update property with start value
	        if (_call_event)
	        {
	            _t[TWEEN.PROPERTY](_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	        }
        
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute PLAY event
	    }
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinishDelay, _call_event);
	}
}


