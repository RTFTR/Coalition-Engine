// Feather disable all


function TweenExists(_tween)
{
	/// @function TweenExists(tween)
	/// @description Checks if tween exists
	/// @param tween	tween id
	/*      
	    Example:
	        if (TweenExists(tween))
			{
	            TweenStop(tween);
	        }
	*/

	SharedTweener();

	if (is_real(_tween))
	{
		_tween = global.TGMS_MAP_TWEEN[? _tween];
		
		if (is_undefined(_tween))
		{
			return false;
		}
	}
	else
	if (is_array(_tween))
	{
	    if (_tween[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
	    {
	        return false;
	    }
	}
	else
	{
	    return false;
	}
    
	if (instance_exists(_tween[TWEEN.TARGET]))
	{
	    return true;
	}

	var _target = _tween[TWEEN.TARGET];
	
	instance_activate_object(_target);

	if (instance_exists(_target))
	{
	    instance_deactivate_object(_target);
	    return true;
	}
	
	return false;
}
