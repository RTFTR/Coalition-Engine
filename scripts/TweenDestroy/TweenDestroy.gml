// Feather disable all

function TweenDestroy(_t)
{
	/// @function TweenDestroy(tween[s])
	/// @description Manually destroys the selected tween[s]
	/// @param tween[s] tween id[s]
	
	// --> NOTE: Tweens are always automatically destroyed when their target instance is destroyed.

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
	    {
	        return undefined;
	    }
    
	    // Invalidate tween handle
	    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
	    {
	        ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
	    }
    
	    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
	    _t[@ TWEEN.ID] = undefined; // Nullify self reference
    
	    // Invalidate tween target or destroy target instance depending on destroy mode
	    if (_t[TWEEN.DESTROY] != 2)
	    { 
	        _t[@ TWEEN.TARGET] = noone; // Invalidate target instance
	    }
	    else
	    { // Destroy Target Instance
	        var _target = _t[TWEEN.TARGET]; // Get target to destroy
        
	        if (instance_exists(_target))
	        {
	            with(_target) instance_destroy();
	        }
	        else
	        {
	            instance_activate_object(_target); // Attempt to activate target by chance it was deactivated
	            with(_target) instance_destroy(); // Attempt to destroy target
	        } 
	    }
    
	    return undefined;
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenDestroy);
	}

	return undefined;
}


function TweenDestroySafe(_t) 
{
	/// @function TweenDestroySafe(tween[s])
	/// @description Safely destroys a tween without error, even if it doesn't exist
	/// @param	tween[s] tween id(s)

	if (is_array(_t))
	{
	    return TweenDestroy(_t);
	}

	if (is_real(_t))
	{
	    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t))
	    {
	        return TweenDestroy(_t);
	    }
    
	    return undefined;
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenDestroySafe);
	}

	return undefined;
}

function TweenDestroyWhenDone()
{
	/// @function TweenDestroyWhenDone(tween[s], destroy, [kill_target])
	/// @description Forces a tween to be destroyed when finished or stopped
	/// @param	tween[s]	tween id(s)
	/// @param	destroy?		destroy tween[s] when finished or stopped?
	/// @param	[kill_target?]	(optional) destroy target when tween finished or stopped?

	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (argument_count == 2)
	    {
	        _t[@ TWEEN.DESTROY] = argument[1];
	    }
	    else
	    {
			var _doDestroy = argument[1];
	        _t[@ TWEEN.DESTROY] = (_doDestroy+argument[2])*_doDestroy;
	    }
	}

	if (is_string(_t))
	{
	    if (argument_count == 2)
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1]);
	    }
	    else
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1], argument[2]);
	    }
	}
}

