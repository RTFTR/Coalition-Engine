// Feather disable all


function TweenIsStopped(_t)
{
	/// @function TweenIsStopped(tween)
	/// @description Checks if tween is stopped
	/// @param tween	tween id
	/*
	    Example:
	        if (TweenIsStopped(tween))
	        {
	            TweenPlay(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] == TWEEN_STATE.STOPPED;
}
