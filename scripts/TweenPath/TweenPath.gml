// Feather disable all

function TweenPath(_target, _ease, _mode, _delta, _delay, _dur, _path, _absolute)
{
	/// @function TweenPath(target,ease,mode,delta,delay,dur,path,absolute)
	/// @description Tween path resource
	/// @param target
	/// @param ease
	/// @param mode
	/// @param delta
	/// @param delay
	/// @param dur
	/// @param path
	/// @param absolute
	
	 /// ext_path__(amount,data[path|absolute|xstart|ystart|xrelative|yrelative|repeat],target)
	static _path_setter = method_get_index(function(_amount, _data, _target)
	{
		var _path = _data[0];
		var _xrelative = _data[4];
		var _yrelative = _data[5];

		with(_target)
		{
		    if (_data[6]) // REPEAT
		    {
		    	var _xstart = _data[2];
		    	var _ystart = _data[3];
	    	
		        var _xDif = path_get_x(_path, 1) - path_get_x(_path, 0); // Could cache these two??
		        var _yDif = path_get_y(_path, 1) - path_get_y(_path, 0);
            
		        if (_amount > 0)
		        {   
		            _xrelative = _xstart + _xDif * floor(_amount);
		            _yrelative = _ystart + _yDif * floor(_amount);
		            _amount = _amount mod 1;
		        }
		        else if (_amount < 0)
		        {
		            _xrelative = _xstart + _xDif * ceil(_amount-1);
		            _yrelative = _ystart + _yDif * ceil(_amount-1);
		            _amount = 1 + _amount mod 1;
		        }
		        else
		        {
		            _xrelative = _xstart;
		            _yrelative = _ystart;
		        }
        
		        x = path_get_x(_path, _amount) + _xrelative;
		        y = path_get_y(_path, _amount) + _yrelative;
		    }
		    else // NO REPEAT
		    {
		        if (_amount > 0)
		        {
		            if (path_get_closed(_path) || _amount < 1)
		            {
		                x = path_get_x(_path, _amount mod 1) + _xrelative;
		                y = path_get_y(_path, _amount mod 1) + _yrelative;
		            }
		            else
		            {
		                var _length = path_get_length(_path) * (abs(_amount)-1);
		                var _direction = point_direction(path_get_x(_path, 0.999), path_get_y(_path, 0.999), path_get_x(_path, 1), path_get_y(_path, 1));
                
		                x = path_get_x(_path, 1) + _xrelative + lengthdir_x(_length, _direction);
		                y = path_get_y(_path, 1) + _yrelative + lengthdir_y(_length, _direction);
		            }
		        }
		        else 
		        if (_amount < 0)
		        {
		            if (path_get_closed(_path))
		            {
		                x = path_get_x(_path, 1+_amount) + _xrelative;
		                y = path_get_y(_path, 1+_amount) + _yrelative;
		            }
		            else
		            {
		                var _length = path_get_length(_path) * abs(_amount);
		                var _direction = point_direction(path_get_x(_path, 0), path_get_y(_path, 0), path_get_x(_path, 0.001), path_get_y(_path, 0.001));
                
		                x = path_get_x(_path, 0) + _xrelative - lengthdir_x(_length, _direction);
		                y = path_get_y(_path, 0) + _yrelative - lengthdir_y(_length, _direction);
		            }
		        }
		        else
		        {
		            x = path_get_x(_path, 0) + _xrelative;
		            y = path_get_y(_path, 0) + _yrelative;
		        }
		    }
		}
	});
	
	static _ = TGMS_BuildProperty(_path_setter, _path_setter, function(){});
	
	var _repeat = (_mode == TWEEN_MODE_REPEAT);

	with(_target)
	{
	    // IF absolute
	    if (_absolute)
	    {
	        return TGMS_TweenFire(_target, _path_setter, _ease, _mode, _delta, _delay, _dur, 0, 1, [_path, _absolute, 0, 0, 0, 0, _repeat]);
	    }
	    else
	    {
	        var _path_xstart = path_get_x(_path, 0);
	        var _path_ystart = path_get_y(_path, 0);
			var _data = [_path, _absolute, _path_xstart, _path_ystart, x-_path_xstart, y-_path_ystart, _repeat];
	        return TGMS_TweenFire(_target, _path_setter, _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	    }
	}
}


