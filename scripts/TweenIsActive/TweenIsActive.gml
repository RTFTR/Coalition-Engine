// Feather disable all

function TweenIsActive(_t) 
{
	/// @function TweenIsActive(tween)
	/// @description Checks if tween is active
	/// @param tween tween id
	/*
	    INFO:
	        Returns true if tween is playing OR actively processing a delay
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED);
}
