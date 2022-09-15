// Feather disable all

function TweenGet(_t, _data_label)
{
	/// @function TweenGet(tween, dataLabel)
	/// @description Returns value for data type of specified tween
	/// @param tween		tween id
	/// @param dataLabel	data "label" string -- see script details
	/*
	    Supported Data Labels:
	        "group"         -- Group which tween belongs to
	        "time"          -- Current time of tween in steps or seconds
	        "time_amount"   -- Sets the tween's time by a relative amount between 0.0 and 1.0 
	        "time_scale"    -- How fast a tween updates : Default = 1.0
	        "duration"      -- How long a tween takes to fully animate in steps or seconds
	        "ease"          -- The easing algorithm used by the tween
	        "mode"          -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"        -- Target instance associated with tween
	        "delta"         -- Toggle timing between seconds(true) and steps(false)
	        "delay"         -- Current timer of active delay
	        "delay_start"   -- The starting duration for a delay timer
	        "start"         -- Start value of the property or properties
	        "destination"   -- Destination value of the property or properties
	        "property"      -- Property or properties effected by the tween
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            duration = TweenGet(tween, "duration");
            
	    ***	The following labels can return multiple values as an array for multi-property tweens:
        
				"start"    
				"destination"
				"property"
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100);
	            startValues = TweenGet(tween, "start");
	            xStart = startValues[0];
	            yStart = startValues[1];
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return undefined; }

	_data_label = global.TGMS_TweenDataIndexes[? _data_label];

	switch(_data_label)
	{
    case TWEEN.PROPERTY:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return = array_create(array_length(_data) div 5);
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[5 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.PROPERTY_RAW];
        }
    break;

    case TWEEN.DESTINATION:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return = array_create(array_length(_data) div 5);
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[3 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.START] + _t[TWEEN.CHANGE];
        }
    break;

    case TWEEN.START:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return = array_create(array_length(_data) div 5);
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[2 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.START];
        }
    break;

    case TWEEN.DELAY:
        if (_t[TWEEN.DELAY] <= 0) { return 0; }
        else            		  { return _t[TWEEN.DELAY]; }
    break;

    case TWEEN.TIME_SCALE:
        return _t[TWEEN.TIME_SCALE] * _t[TWEEN.DIRECTION];
    break;

    default: // Directly access tween index
        return _t[_data_label]
	}
}
