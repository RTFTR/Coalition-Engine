// Feather disable all

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER)

function TweenCalc(_t)
{
	/// @function TweenCalc(tween)
	/// @description Returns calculated value from tween's current state
	/// @param tween	tween id
	/*
	    INFO:
	        Returns a calculated value using a tweens current state.
        
	    EXAMPLE:
	        // Create defined tween ... we don't have to provide any property
	        tween = TweenFire(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at its current state
	        x = TweenCalc(tween);
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)){ return 0; }

	var _duration = _t[TWEEN.DURATION];

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], 0, 1, _duration);
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        _return[_dataIndex] = _duration == 0 ? _start : lerp(_start, _dest, _amount);
	    }
		
	    return _return; 
	}
	else // SINGLE PROPERTY
	{
	    // Return start if duration is invalid
	    if (_duration == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);
	}
} _ = TweenCalc;


function TweenCalcAmount(_t, _amount)
{
	/// @function TweenCalcAmount(tween,amount)
	/// @description Returns calculated value using tween's state and a set amount
	/// @param tween	tween id
	/// @param amount	relative time between 0.0 and 1.0
	/*
	    INFO:
	        Returns a calculated value using a tweens current state
	        at a relative point in time.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at 25% through time
	        x = TweenCalcAmount(tween, 0.25);
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return 0; }

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    _amount = script_execute(_t[TWEEN.EASE], _amount, 0, 1, 1); // Cache calculated amount
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        return[_dataIndex] = _t[TWEEN.DURATION] == 0 ? _start : lerp(_start, _dest, _amount);
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_amount, 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], 1);
	}
} _ = TweenCalcAmount;


function TweenCalcTime(_t, _time)
{
	/// @function TweenCalcTime(tween,time)
	/// @description Returns calculated value using a tween's state at a set time
	/// @param tween	tween id
	/// @param time		specific time in steps or seconds
	/*      
	    INFO:
	        Returns a calculated value using a tween's current state
	        at a specified point in time.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at 1.5 seconds through time
	        x = TweenCalcAmount(tween, 1.5);
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return 0; }

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], _time, 0, 1, _t[TWEEN.DURATION]);
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        _return[_dataIndex] = _t[TWEEN.DURATION] == 0 ? _start : lerp(_start, _dest, _amount);
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_time, 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]);
	}
} _ = TweenCalcTime;






