// Feather disable all


function TweenResume(_t)
{
	/// @function TweenResume(tween[s])
	/// @description Resumes the selected tween[s]
	/// @param tween[s] tween id

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        if (_t[TWEEN.DELAY] > 0)
	        {
	            _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME_DELAY);
	        }
	        else
	        {
	            _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME);
	        }
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenResume);
	}
}
