// Feather disable all


function TweenReverse(_t)
{
	/// @function TweenReverse(tween[s])
	/// @description Reverses the selected tween[s]
	/// @param tween[s] tween id

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] > 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];
	        _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_REVERSE);
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenReverse);
	}
}
