// Feather disable all


function TweenIsPaused(_t)
{
	/// @function TweenIsPaused(tween)
	/// @description Checks if tween is paused
	/// @param tween	tween id
	/*
	    Example:
	        if (TweenIsPaused(tween))
	        {
	            TweenResume(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] == TWEEN_STATE.PAUSED;
}
