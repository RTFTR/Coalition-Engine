// Feather disable all
/// @ignore
function TGMS_EasyTweens() {}

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

function TweenEasyUseDelta(_use_seconds) 
{
	/// @function TweenEasyUseDelta(use_seconds?)
	/// @description Toggle between using step or delta timing for "Easy Tweens"
	/// @param use_seconds?		Use seconds timing? true = seconds | false = steps
	
	SharedTweener();
	global.TGMS_EasyDelta = _use_seconds;
}_=TweenEasyUseDelta;


function TweenEasyMove() 
{
	/// @function TweenEasyMove(x1, y1, x2, y2, delay, duration, ease, [mode])
	/// @description Tweens instance's x/y position
	/// @param x1
	/// @param y1
	/// @param x2
	/// @param y2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyMove"))
	{
		if (TweenExists(__TweenEasyMove))
		{
			TweenDestroy(__TweenEasyMove);
		}
	}

	__TweenEasyMove = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "x", argument[0], argument[2], "y", argument[1], argument[3]);
	return __TweenEasyMove;
}_=TweenEasyMove;


function TweenEasyScale()
{
	/// @function TweenEasyScale(x1,y1,x2,y2,delay,dur,ease,[mode])
	/// @description Tweens instance's image scale
	/// @param x1
	/// @param y1
	/// @param x2
	/// @param y2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyScale"))
	{
		if (TweenExists(__TweenEasyScale))
		{
			TweenDestroy(__TweenEasyScale);
		}
	}

	__TweenEasyScale = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "image_xscale", argument[0], argument[2], "image_yscale", argument[1], argument[3]);
	return __TweenEasyScale;
}_=TweenEasyScale;


function TweenEasyRotate()
{
	/// @function TweenEasyRotate(angle1,angle2,delay,dur,ease,[mode])
	/// @description Tweens instance's image angle
	/// @param angle1
	/// @param angle2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyRotate"))
	{
		if (TweenExists(__TweenEasyRotate))
		{
			TweenDestroy(__TweenEasyRotate);
		}
	}

	__TweenEasyRotate = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_angle", argument[0], argument[1]);
	return __TweenEasyRotate;
}_=TweenEasyRotate;


function TweenEasyFade()
{
	/// @function TweenEasyFade(alpha1,alpha2,delay,dur,ease,[mode])
	/// @description Tweens instance's image alpha
	/// @param alpha1
	/// @param alpha2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	SharedTweener();
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyFade"))
	{
		if (TweenExists(__TweenEasyFade))
		{
			TweenDestroy(__TweenEasyFade);
		}
	}

	__TweenEasyFade = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_alpha", argument[0], argument[1]);
	return __TweenEasyFade;
}_=TweenEasyFade;


function TweenEasyTurn()
{
	/// @function TweenEasyTurn(dir1,dir2,delay,dur,ease,[mode])
	/// @description Tweens instance's direction
	/// @param dir1
	/// @param dir2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	SharedTweener();
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyTurn"))
	{
		if (TweenExists(__TweenEasyTurn))
		{
			TweenDestroy(__TweenEasyTurn);
		}
	}

	__TweenEasyTurn = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "direction", argument[0], argument[1]);
	return __TweenEasyTurn;
}_=TweenEasyTurn;


function TweenEasyBlend()
{
	/// @function TweenEasyBlend(col1,col2,delay,dur,ease,[mode])
	/// @description Tweens instance's image blend colour
	/// @param col1
	/// @param col2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyBlend"))
	{
		if (TweenExists(__TweenEasyBlend))
		{
			TweenDestroy(__TweenEasyBlend);
		}
	}

	__TweenEasyBlend = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_blend", argument[0], argument[1]);
	return __TweenEasyBlend;
}_=TweenEasyBlend;


function TweenEasyImage()
{
	/// @function TweenEasyImage(index1,index2,delay,dur,ease,[mode])
	/// @description Tweens instance's image index
	/// @param index1
	/// @param index2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	SharedTweener();
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyImage"))
	{
		if (TweenExists(__TweenEasyImage))
		{
			TweenDestroy(__TweenEasyImage);
		}
	}

	__TweenEasyImage = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_index", argument[0], argument[1]);
	return __TweenEasyImage;
}_=TweenEasyImage;


function TweenEasySpeed()
{
	/// @function TweenEasySpeed(spd1,spd2,delay,dur,ease,[mode])
	/// @description Tweens instance's speed
	/// @param spd1
	/// @param spd2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasySpeed"))
	{
		if (TweenExists(__TweenEasySpeed))
		{
			TweenDestroy(__TweenEasySpeed);
		}
	}

	__TweenEasySpeed = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "speed", argument[0], argument[1]);
	return __TweenEasySpeed;
}_=TweenEasySpeed;


function TweenEasySpeedHV()
{
	/// @function TweenEasySpeedHV(hspd1,vspd1,hspd2,vspd2,delay,dur,ease,[mode])
	/// @description Tweens instance's hspeed/vspeed
	/// @param hspd1
	/// @param vspd1 
	/// @param hspd2
	/// @param vspd2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	SharedTweener();

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasySpeedHV"))
	{
		if (TweenExists(__TweenEasySpeedHV))
		{
			TweenDestroy(__TweenEasySpeedHV);
		}
	}

	__TweenEasySpeedHV = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "hspeed", argument[0], argument[2], "vspeed", argument[1], argument[3]);
	return __TweenEasySpeedHV;
}_=TweenEasySpeedHV;



