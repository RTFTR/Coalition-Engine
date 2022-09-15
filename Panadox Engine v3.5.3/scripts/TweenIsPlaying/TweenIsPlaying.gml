// Feather disable all

function TweenIsPlaying(_t)
{
	/// @function TweenIsPlaying(tween)
	/// @description Checks if tween is playing
	/// @param tween	tween id
	/*
	    NOTE:
	        ** Will NOT return true if tween is processing a delay **
        
	    Example:
	        if (TweenIsPlaying(tween))
	        {
	            TweenPause(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] >= 0;
}
