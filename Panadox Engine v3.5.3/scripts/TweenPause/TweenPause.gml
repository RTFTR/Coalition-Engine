// Feather disable all


function TweenPause(_t)
{
	/// @function TweenPause(tween[s])
	/// @description Pauses the selected tween[s]
	/// @param tween[s] tween id

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE);
	    }
		else
	    if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE_DELAY);
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenPause);
	}
}
